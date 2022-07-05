export interface ServerToClientEvents {
	noArg: () => void
	basicEmit: (a: number, b: string, c: Buffer) => void
	withAck: (d: string, callback: (e: number) => void) => void
	auth: (data: any) => void
	chat_message: (data: any) => void
	submit_order: (data: any) => void
	order_add_item: (data: any) => void
	order_remove_item: (data: any) => void
	order_status_change: (data: any) => void
}

export interface ClientToServerEvents {
	auth: (data: any) => void
	create: (room: any) => void
	chat_message: (data: any) => void
	submit_order: (data: any) => void
	order_add_item: (data: any) => void
	order_remove_item: (data: any) => void
	order_status_change: (data: any, callback: (msg: {success: boolean, message: string}) => void) => Promise<void>
}

export interface InterServerEvents {
	ping: () => void
}

export interface SocketData {
	name: string
	age: number

}
