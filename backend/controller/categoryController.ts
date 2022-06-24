import { Request, Response, NextFunction } from 'express';
import { Category } from '../models/Food';

export const getCategories = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.log('categories');
  try {
    const categories = await Category.find();
    return res.status(200).json(categories);
  } catch (err) {
    return res.status(400).json({ message: err });
  }
};

export const addCategory = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name } = req.body;
  try {
    const category = new Category({
      name: name,
    });
    await category.save();
    res.status(200).json(category);
  } catch (err) {
    res.status(400).json({ message: err });
  }
};
