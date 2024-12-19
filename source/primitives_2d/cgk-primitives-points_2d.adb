--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Transformations_2D;
with CGK.Primitives.Vectors_2D;
with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.Points_2D is

   use CGK.Primitives.XYs;
   use CGK.Reals;

   ---------------------
   -- Create_Point_2D --
   ---------------------

   function Create_Point_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Point_2D is
   begin
      return (Coordinates => Create_XY (X, Y));
   end Create_Point_2D;

   ---------------------
   -- Create_Point_2D --
   ---------------------

   function Create_Point_2D (XY : CGK.Primitives.XYs.XY) return Point_2D is
   begin
      return (Coordinates => XY);
   end Create_Point_2D;

   --------------
   -- Distance --
   --------------

   function Distance
     (Point_1 : Point_2D;
      Point_2 : Point_2D) return CGK.Reals.Real
   is
      DX : constant Real := X (Point_1.Coordinates) - X (Point_2.Coordinates);
      DY : constant Real := Y (Point_1.Coordinates) - Y (Point_2.Coordinates);

   begin
      return Elementary_Functions.Sqrt (DX * DX + DY * DY);
   end Distance;

   --------------
   -- Is_Equal --
   --------------

   function Is_Equal
     (Self             : Point_2D;
      Other            : Point_2D;
      Linear_Tolarance : CGK.Reals.Real) return Boolean is
   begin
      return Distance (Self, Other) <= Linear_Tolarance;
   end Is_Equal;

   ---------------
   -- Transform --
   ---------------

   procedure Transform
     (Self           : in out Point_2D;
      Transformation : CGK.Primitives.Transformations_2D.Transformation_2D) is
   begin
      Self.Coordinates :=
        CGK.Primitives.Transformations_2D.Transform
          (Transformation, Self.Coordinates);
   end Transform;

   ---------------
   -- Translate --
   ---------------

   procedure Translate
     (Self   : in out Point_2D;
      Offset : CGK.Primitives.Vectors_2D.Vector_2D) is
   begin
      Self.Coordinates := @ + CGK.Primitives.Vectors_2D.XY (Offset);
   end Translate;

   -------
   -- X --
   -------

   function X (Self : Point_2D) return CGK.Reals.Real is
   begin
      return X (Self.Coordinates);
   end X;

   --------
   -- XY --
   --------

   function XY (Self : Point_2D) return CGK.Primitives.XYs.XY is
   begin
      return Self.Coordinates;
   end XY;

   -------
   -- Y --
   -------

   function Y (Self : Point_2D) return CGK.Reals.Real is
   begin
      return Y (Self.Coordinates);
   end Y;

end CGK.Primitives.Points_2D;
