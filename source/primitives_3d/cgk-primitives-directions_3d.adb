--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Vectors_3D;

package body CGK.Primitives.Directions_3D is

   use CGK.Primitives.Vectors_3D;
   use CGK.Primitives.XYZs;
   use CGK.Reals;

   ------------------
   -- As_Vector_3D --
   ------------------

   function As_Vector_3D
     (Self : Direction_3D) return CGK.Primitives.Vectors_3D.Vector_3D is
   begin
      return Create_Vector_3D (XYZ (Self));
   end As_Vector_3D;

   -------------------
   -- Unchecked_Set --
   -------------------

   procedure Unchecked_Set
     (Self : out Direction_3D;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real;
      Z    : CGK.Reals.Real) is
   begin
      Self.Coordinates := Create_XYZ (X, Y, Z);
   end Unchecked_Set;

   -------
   -- X --
   -------

   function X (Self : Direction_3D) return CGK.Reals.Real is
   begin
      return X (Self.Coordinates);
   end X;

   ---------
   -- XYZ --
   ---------

   function XYZ (Self : Direction_3D) return CGK.Primitives.XYZs.XYZ is
   begin
      return Self.Coordinates;
   end XYZ;

   -------
   -- Y --
   -------

   function Y (Self : Direction_3D) return CGK.Reals.Real is
   begin
      return Y (Self.Coordinates);
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : Direction_3D) return CGK.Reals.Real is
   begin
      return Z (Self.Coordinates);
   end Z;

end CGK.Primitives.Directions_3D;
