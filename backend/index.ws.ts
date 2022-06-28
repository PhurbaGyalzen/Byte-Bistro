import { createServer } from 'http'
import { Server } from 'socket.io'
import { Express } from 'express'
import { Cart, ICart } from '@models/Cart'
import { User } from '@models/Users'
import { jwtSigner, jwtVerify } from 'middlewares/jwt-auth'
import { IAuthenticatedUser } from '@mytypes/Auth'

const initWebSocket = (app: Express) => {
	const httpServer = createServer(app)
	const io = new Server(httpServer, {
		cors: {
			origin: '*',
		},
	})

	io.on('connection', async (socket) => {
		let currUserId = 'sanjib'
		console.log('a user connected')
		socket.on('set_user_id', (data) => {
			console.log(data)
			currUserId = data.userId
			socket.join(currUserId)
			// socket.send({
			// 	socketId: socket.id,
			// })
		})

		socket.on('auth', (data) => {
			console.log('/auth')
			console.log(data)
			let userInfo: IAuthenticatedUser | null = null
			try {
				userInfo = jwtVerify(data.token)
			} catch (e) {}
			if (userInfo) {
				// if (userInfo.)
				currUserId = userInfo.username
			}
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

		// emtted by admin
		socket.on('order_status_change', async (data) => {
			console.log('admin: requested order status change')
			// console.log((await io.fetchSockets())[0].id)
			console.log(currUserId)
			if (currUserId) {
				io.to(currUserId).emit('order_status_change', {
					orderId: data.orderId,
					orderStatus: data.orderStatus,
					orderDurationMin: data.orderDurationMin,
				})
			}
		})
	})

	io.emit('order_confirmed', { order_id: '34hg3434j' })

	return httpServer
}

export default initWebSocket
