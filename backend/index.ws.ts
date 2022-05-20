import { createServer } from 'http'
import { Server } from 'socket.io'
import { Express } from 'express'
import { Cart, ICart } from '@models/Food'

const initWebSocket = (app: Express) => {
	const httpServer = createServer(app)
	const io = new Server(httpServer, {
		cors: {
			origin: '*',
		},
	})

	io.on('connection', (socket) => {
		console.log('a user connected')
		socket.on('message', (data) => {
			console.log(data)
			socket.send({
				socketId: socket.id,
			})
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
			socket.emit('order_status_change', {
				orderId: data.orderId,
				orderStatus: data.orderStatus,
				orderDurationMin: data.orderDurationMin,
			})
		})
	})

	io.emit('order_confirmed', { order_id: '34hg3434j' })

	return httpServer
}

export default initWebSocket
