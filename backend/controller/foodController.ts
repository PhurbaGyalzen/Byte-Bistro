import { Request, Response, NextFunction } from 'express';
import { Food } from '../models/Food';

// controller for viewing single food
export const getFood = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const food = await Food.findById(req.params.foodId);
    res.status(200).json(food);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};

// controller for viewing all food
export const viewFood = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const foods = await Food.find();
    res.status(200).json(foods);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};

// controller to add food
export const putFood = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name, price, description, image } = req.body;
  try {
    const food = new Food({
      name: name,
      price: price,
      description: description,
      image: image,
      // image: images,
    });
    await food.save();
    res.status(200).json(food);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};

// controller to update single food
export const updateFood = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name, price, description, image } = req.body;
  try {
    const food = await Food.updateOne(
      { _id: req.params.foodId },
      {
        $set: {
          name: req.body.name,
          price: req.body.price,
          description: req.body.description,
          image: req.body.image,
        },
      }
    );
    res.status(200).json(food);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};

// controller to delete single food
export const deleteFood = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const food = await Food.remove({ _id: req.params.foodId });
    res.status(200).json(food);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};

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
