import { Request, Response, NextFunction } from 'express'

const enableCors = (req: Request, res: Response, next: NextFunction) => {
	res.set('Access-Control-Allow-Origin', req.get('origin') || '*')
	// res.set('Access-Control-Allow-Origin', '*')
	res.set('Access-Control-Allow-Credentials', 'true')
	res.set(
		'Access-Control-Allow-Methods',
		'HEAD, OPTIONS, GET, POST, PUT, PATCH, DELETE'
	)
	res.set(
		'Access-Control-Allow-Headers',
		req.get('Access-Control-Request-Headers') || '*'
	)
	if (req.method === 'OPTIONS') {
		return res.sendStatus(200)
	}
	return next()
}

export default enableCors