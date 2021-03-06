import { Router, Request, Response, NextFunction } from 'express';
import { uploadImage } from 'middlewares/file';
import {
  signupUser,
  signinUser,
  authGoogle,
  authGoogleCallback,
  authFailure,
  authSuccess,
  resetPassword,
  verifyResetPassword,
  googleAuthentication,
  setNewPassword,
} from '../controller/authController';
import { User } from '@models/Users';
import { verifyUser } from 'middlewares/jwt-auth';
import bcrypt from 'bcrypt';

const router = Router();

router.post('/signup', signupUser);
router.post(
  '/signin',

  signinUser
);
router.post('/resetPassword', resetPassword);
router.post('/verifyResetPassword', verifyResetPassword);
router.post('/setNewPassword', verifyUser, setNewPassword);
router.post('/google', googleAuthentication);
// router.get('/google/callback', authGoogleCallback)
// router.get('/google/failed', authFailure)
// router.get('/google/success', authSuccess)

router.get(
  '/all_user',
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const users = await User.find();
      res.status(200).json(users);
    } catch (err) {
      res.status(400).json({ message: err });
    }
  }
);

router.get(
  '/user/:id',
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const user = await User.findById(req.params.id);
      res.status(200).json(user);
    } catch (err) {
      res.status(400).json({ message: err });
    }
  }
)
router.get(
  '/one_user',
  verifyUser,
  async (req: Request, res: Response, next: NextFunction) => {
    console.log('req.user');
    console.log(req.user);

    try {
      const user = await User.findById(req.user?.id);

      res.status(200).json(user);
    } catch (err) {
      res.status(400).json({ message: err });
    }
  }
);

router.put(
  '/profile_update',
  verifyUser,
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const users = await User.findByIdAndUpdate(req.user?.id, {
        $set: {
          fullname: req.body.fullname,
          email: req.body.email,
          phones: req.body.phone,
          address: req.body.address,
          bio: req.body.bio,
        },
      });
      res.status(200).json(users);
    } catch (err) {
      res.status(400).json({ message: err });
    }
  }
);

//change password
router.put(
  '/changepassword',
  verifyUser,
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      await User.findById(req.user?.id)
        .then(async (user) => {
          // const hash = bcrypt.hash(req.body.newpassword, 12);
          await bcrypt.compare(
            req.body.oldPassword,
            user?.passwordHash!,
            async (err, result) => {
              if (!result) {
                console.log('err');
                console.log(err);
                return res.status(401).json({
                  message: '!=oldPassword',
                });
              }

              if (result) {
                console.log('result');
                console.log(result);
                if (req.body.oldPassword == req.body.newPassword) {
                  return res.status(401).json({
                    message: 'old==new',
                    // message: "failed to change to password due to same old and new"
                  });
                }

                if (req.body.oldPassword != req.body.newPassword) {
                  const hash = await bcrypt.hash(req.body.newPassword, 12);
                  console.log('req.body.oldPassword != req.body.newPassword');

                  const user = await User.findByIdAndUpdate(req.user?.id, {
                    $set: {
                      passwordHash: hash,
                    },
                  })
                    .then((result) => {
                      return res.status(200).json({
                        // message: "password changed",
                        message: 'success',
                      });
                    })
                    .catch((err) => {
                      return res.status(400).json({
                        message: err,
                      });
                    });
                }
              }
            }
          );
          //  return "failed";
        })
        .catch((err) => {
          return res.status(400).json({
            message: err,
          });
        });
    } catch (err) {
      //try end

      res.status(400).json({ message: err });
    }
  }
);

router.patch(
  '/profile',
  uploadImage.single('profile'),
  verifyUser,
  async (req: Request, res: Response, next: NextFunction) => {
    const imageFileName = req.file?.filename;
    const imageFileUrl = `images/${imageFileName}`;
    try {
      const users = await User.findByIdAndUpdate(req.user?.id, {
        $set: {
          profile: imageFileUrl,
        },
      });
      res.status(200).json(users);
    } catch (err) {
      res.status(400).json({ message: err });
    }
  }
);

export default router;
