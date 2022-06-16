import { Request } from 'express'
import multer, { FileFilterCallback } from 'multer'
import path from "path";

type DestinationCallback = (error: Error | null, destination: string) => void
type FileNameCallback = (error: Error | null, filename: string) => void

const fileStorage = multer.diskStorage({
  destination: (reqest: Request, file: Express.Multer.File, callback: DestinationCallback): void => {
    callback(null, "./public/images");
  },
  filename: (request: Request, file: Express.Multer.File, callback: FileNameCallback): void => {
    const fileName = file.originalname.toLowerCase().split(" ").join("-");
    callback(null, `${Date.now()}-${fileName}`);
  }}
)

const fileFilter = (request: Request, file: Express.Multer.File, callback: FileFilterCallback): void => {
  const ext = path.extname(file.originalname);
  if (
    ext !== ".png" &&
    ext !== ".jpg" &&
    ext !== ".jpeg" &&
    ext !== "gif"
  ) {
    return callback(new Error("Only images are allowed"));
  }
  callback(null, true);
}

// optimized function to upload Image Files in uploads folder
export const uploadImage = multer({ storage: fileStorage, fileFilter: fileFilter });

