import mongoose, { Document, Schema, Types } from 'mongoose';

interface IProfile {
  name: string;
  age: number;
  updatedDate: Date;
  isAdmin: boolean;
}

interface IProfileDoc extends IProfile, Document {}

const ProfileSchemaFields: Record<keyof IProfile, any> = {
  name: {
    type: String,
  },
  age: {
    type: Number,
  },
  updatedDate: {
    type: Date,
  },
  isAdmin: {
    type: Boolean,
  },
};

const ProfileSchema = new mongoose.Schema<IProfileDoc>(ProfileSchemaFields, {
  timestamps: true,
});

export const Profile = mongoose.model<IProfile>('Profile', ProfileSchema);
