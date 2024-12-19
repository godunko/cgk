--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Points_3D;

package body CGK.Primitives.Vectors_3D is

   use CGK.Primitives.XYZs;
   use CGK.Reals;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Vector_3D; Right : CGK.Reals.Real) return Vector_3D is
   begin
      return Create_XYZ (X (Left) * Right, Y (Left) * Right, Z (Left) * Right);
   end "*";

   ----------------------
   -- Create_Vector_3D --
   ----------------------

   function Create_Vector_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Vector_3D is
   begin
      return Create_XYZ (X, Y, Z);
   end Create_Vector_3D;

   ----------------------
   -- Create_Vector_3D --
   ----------------------

   function Create_Vector_3D
     (XYZ : CGK.Primitives.XYZs.XYZ) return Vector_3D is
   begin
      return Vector_3D (XYZ);
   end Create_Vector_3D;

   ----------------------
   -- Create_Vector_3D --
   ----------------------

   function Create_Vector_3D
     (Point_1 : CGK.Primitives.Points_3D.Point_3D;
      Point_2 : CGK.Primitives.Points_3D.Point_3D) return Vector_3D is
   begin
      return Vector_3D (Points_3D.XYZ (Point_2) - Points_3D.XYZ (Point_1));
   end Create_Vector_3D;

   -----------
   -- Cross --
   -----------

   function Cross
     (Left  : Vector_3D;
      Right : Vector_3D) return Vector_3D is
   begin
      return
        Create_XYZ
          (Y (Left) * Z (Right) - Z (Left) * Y (Right),
           Z (Left) * X (Right) - X (Left) * Z (Right),
           X (Left) * Y (Right) - Y (Left) * X (Right));
   end Cross;

   -------
   -- X --
   -------

   function X (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return X (XYZs.XYZ (Self));
   end X;

   ---------
   -- XYZ --
   ---------

   function XYZ (Self : Vector_3D) return CGK.Primitives.XYZs.XYZ is
   begin
      return XYZs.XYZ (Self);
   end;

   -------
   -- Y --
   -------

   function Y (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return Y (XYZs.XYZ (Self));
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return Z (XYZs.XYZ (Self));
   end Z;

end CGK.Primitives.Vectors_3D;
