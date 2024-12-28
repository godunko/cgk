--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Points_3D;

package body CGK.Primitives.Vectors_3D is

   use CGK.Mathematics.Vectors_3;
   use CGK.Reals;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Vector_3D; Right : CGK.Reals.Real) return Vector_3D is
   begin
      return Vector_3D (Vector_3 (Left) * Right);
   end "*";

   ----------------------
   -- Create_Vector_3D --
   ----------------------

   function Create_Vector_3D
     (Point_1 : CGK.Primitives.Points_3D.Point_3D;
      Point_2 : CGK.Primitives.Points_3D.Point_3D) return Vector_3D is
   begin
      return
        Vector_3D
          (CGK.Primitives.XYZs.As_Vector_3 (Points_3D.XYZ (Point_2))
             - CGK.Primitives.XYZs.As_Vector_3 (Points_3D.XYZ (Point_1)));
   end Create_Vector_3D;

   -----------
   -- Cross --
   -----------

   function Cross
     (Left  : Vector_3D;
      Right : Vector_3D) return Vector_3D is
   begin
      return Cross_Product (Left, Right);
   end Cross;

   -------
   -- X --
   -------

   function X (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return Self (0);
   end X;

   ---------
   -- XYZ --
   ---------

   function XYZ (Self : Vector_3D) return CGK.Primitives.XYZs.XYZ is
   begin
      return CGK.Primitives.XYZs.As_XYZ (Vector_3 (Self));
   end;

   -------
   -- Y --
   -------

   function Y (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return Self (1);
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : Vector_3D) return CGK.Reals.Real is
   begin
      return Self (2);
   end Z;

end CGK.Primitives.Vectors_3D;
