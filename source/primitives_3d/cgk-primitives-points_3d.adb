--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Vectors_3D;

package body CGK.Primitives.Points_3D is

   use CGK.Mathematics.Vectors_3;

   ---------
   -- "+" --
   ---------

   function "+"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D) return Point_3D is
   begin
      return
        Point_3D
          (Vector_3 (Left) + CGK.Primitives.Vectors_3D.As_Vector_3 (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D) return Point_3D is
   begin
      return
        Point_3D
          (Vector_3 (Left) - CGK.Primitives.Vectors_3D.As_Vector_3 (Right));
   end "-";

   -------
   -- X --
   -------

   function X (Self : Point_3D) return CGK.Reals.Real is
   begin
      return Self (0);
   end X;

   ---------
   -- XYZ --
   ---------

   function XYZ (Self : Point_3D) return CGK.Primitives.XYZs.XYZ is
   begin
      return CGK.Primitives.XYZs.As_XYZ (Vector_3 (Self));
   end XYZ;

   -------
   -- Y --
   -------

   function Y (Self : Point_3D) return CGK.Reals.Real is
   begin
      return Self (1);
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : Point_3D) return CGK.Reals.Real is
   begin
      return Self (2);
   end Z;

end CGK.Primitives.Points_3D;
