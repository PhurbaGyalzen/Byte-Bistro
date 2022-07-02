import { createServer } from 'http'
import { Server } from 'socket.io'
import { Express } from 'express'
import { Cart, ICart, CartStatus } from '@models/Cart'
import { User } from '@models/Users'
import { jwtVerify } from 'middlewares/jwt-auth'
import { IAuthenticatedUser } from '@mytypes/Auth'
import { ClientToServerEvents, InterServerEvents, ServerToClientEvents, SocketData } from 'typings/socketio'

const initWebSocket = (app: Express) => {
	const httpServer = createServer(app)
	const io = new Server<ClientToServerEvents, ServerToClientEvents, InterServerEvents, SocketData>(httpServer, {
	// const io = new Server(httpServer, {
		cors: {
			origin: '*',
		},
	})

	io.on('connection', async (socket) => {
		let currUser: IAuthenticatedUser | null
		console.log('a user connected')
		// maybe nesting events inside `auth` event would prevent checking null on `currUser`
		socket.on('auth', (data) => {
			console.log('/auth')
			console.log(data)
			let userInfo: IAuthenticatedUser | null = null
			try {
				userInfo = jwtVerify(data.token)
			} catch (e) {}
			if (userInfo) {
				currUser = userInfo
			}
		})
		socket.on('set_user_id', (data) => {
			console.log(data)
			currUser!.id = data.userId
			socket.join(currUser!.username)
			// socket.send({
			// 	socketId: socket.id,
			// })
		})

		socket.on('chat_message', (data) => {
			console.log(data)
			socket.emit('chat_message', {
				username: 'Server',
				message: new Date().toISOString(),
			})
		})
		socket.on('submit_order', async (data: ICart) => {
			const order = new Cart(data)
			try {
				await order.save()
			} catch (e: any) {
				socket.emit('submit_order', {
					error: e.message,
				})
			}
			socket.emit('submit_order', {
				message: 'Order submitted successfully',
				orderId: order.id,
			})
		})
		socket.on('order_add_item', async (data) => {
			const cartId = data.cartId
			const cart = await Cart.findByIdAndUpdate(cartId, {
				$push: {
					items: data.item,
				},
			})
			if (!cart) {
				socket.emit('order_add_item', {
					error: 'Cart not found',
				})
			} else {
				socket.emit('order_add_item', {
					message: 'Order added successfully',
					orderId: cart.id,
				})
			}
		})
		socket.on('order_remove_item', async (data) => {
			const cartId = data.cartId
			const cart = await Cart.findByIdAndUpdate(cartId, {
				$pull: {
					items: {
						foodId: data.item.foodId,
					},
				},
			})
			if (!cart) {
				socket.emit('order_remove_item', {
					error: 'Cart not found',
				})
			} else {
				socket.emit('order_remove_item', {
					message: 'Order removed successfully',
					orderId: cart.id,
				})
			}
		})

		socket.on('order_status_change', async (data, callback) => {
			console.log('admin: requested order status change')
			if (!currUser) {
				console.log('user not found')
				callback({
					success: false,
					message: 'user not found'
				})
				return
			}
			if (!currUser.isAdmin) {
				console.log('user is not admin. No events will be emitted.')
				callback({
					success: false,
					message: 'user is not admin'
				})
				return
			}
			try {
				const cart = await Cart.findByIdAndUpdate(data.orderId, {
					$set: {
						'status': data.orderStatus
					}
				})
				if (!cart?.userId) {
					console.log('no cart found')
					return callback({
						success: false,
						message: 'No cart found.'
					})
				}
				console.log('sending to room: ' + cart?.userId)
				// io.to(currUser.username).emit('order_status_change', {
				// io.to(cart!.userId.toString()).emit('order_status_change', {
				io.emit('order_status_change', {
					orderId: data.orderId,
					orderStatus: data.orderStatus,
					orderDurationMin: cart?.duration || 0
				})
				// console.log(callback)
				callback({
					success: true,
					message: 'Order status changed'
				})
			} catch (e: any) {
				callback({
					success: false,
					message: e.message
				})
			}

			// console.log((await io.fetchSockets())[0].id)
		})
	})


	return httpServer
}

export default initWebSocket
