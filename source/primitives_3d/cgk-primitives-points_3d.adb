--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Vectors_3D;

package body CGK.Primitives.Points_3D is

   use CGK.Primitives.Vectors_3D;
   use CGK.Primitives.XYZs;
   use CGK.Reals;

   ---------
   -- "+" --
   ---------

   function "+"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D) return Point_3D is
   begin
      return Point_3D (XYZ (Left) + XYZ (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D) return Point_3D is
   begin
      return Point_3D (XYZ (Left) - XYZ (Right));
   end "-";

   ---------------------
   -- Create_Point_3D --
   ---------------------

   function Create_Point_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Point_3D is
   begin
      return Create_XYZ (X, Y, Z);
   end Create_Point_3D;

   ---------------------
   -- Create_Point_3D --
   ---------------------

   function Create_Point_3D (XYZ : CGK.Primitives.XYZs.XYZ) return Point_3D is
   begin
      return Point_3D (XYZ);
   end Create_Point_3D;

   -------
   -- X --
   -------

   function X (Self : Point_3D) return CGK.Reals.Real is
   begin
      return X (XYZ (Self));
   end X;

   ---------
   -- XYZ --
   ---------

   function XYZ (Self : Point_3D) return CGK.Primitives.XYZs.XYZ is
   begin
      return CGK.Primitives.XYZs.XYZ (Self);
   end XYZ;

   -------
   -- Y --
   -------

   function Y (Self : Point_3D) return CGK.Reals.Real is
   begin
      return Y (XYZ (Self));
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : Point_3D) return CGK.Reals.Real is
   begin
      return Z (XYZ (Self));
   end Z;

end CGK.Primitives.Points_3D;
