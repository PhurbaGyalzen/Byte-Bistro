import { Request, Response, NextFunction } from 'express'
import { Food } from '../models/Food'

export const getFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const food = await Food.findById(req.params.foodId)
	if (!food) {
		return res.status(404).json({
			success: false,
			message: 'Food not found',
		})
	}
	return res.json({ success: true, data: food })
}

// controller for viewing all blog
export const viewFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const foods = await Food.find()
		res.status(200).json(foods)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

export const putFood = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const { name, price, description, images } = req.body
	try {
		const food = new Food({
			name: name,
			price: price,
			description: description,
			image: images,
		})
		await food.save()
		res.status(200).json(food)
	} catch (err) {
		res.status(400).json({ message: err })
	}
}

// //
// export const addFood(String name, int price, String description, String images) async {
//         var data = await RoomService.addFood(name, price, description, images);
//         if (data != null) {
//           foodList.value = data;
//           return isData(true);
//         }
//     }

// Add new Room
//  static Future<List<RoomModel>?> addRoom(
//     String name, String description, int price) async {
//   const endpoint = PersistentHtpp.baseUrl + 'room/';

//   var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
//     "name": name,
//     "description": description,
//     "price": price.toString(),
//   });
//   if (response.statusCode == 201) {
//     var jsonString = response.body;
//     return roomModelFromJson(jsonString);
//   } else {
//     throw Exception('Failed to add Room');
//     // return null;
//   }
// }