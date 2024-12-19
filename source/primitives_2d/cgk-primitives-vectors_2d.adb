--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body CGK.Primitives.Vectors_2D is

   use CGK.Primitives.XYs;
   use CGK.Reals;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Vector_2D; Right : CGK.Reals.Real) return Vector_2D is
   begin
      return (Coordinates => Left.Coordinates * Right);
   end "*";

   ---------
   -- "-" --
   ---------

   function "-" (Self : Vector_2D) return Vector_2D is
   begin
      return (Coordinates => -Self.Coordinates);
   end "-";

   ---------
   -- "/" --
   ---------

   function "/"
     (Left : Vector_2D; Right : CGK.Reals.Real) return Vector_2D is
   begin
      return (Coordinates => Left.Coordinates / Right);
   end "/";

   ----------------------
   -- Create_Vector_2D --
   ----------------------

   function Create_Vector_2D (XY : CGK.Primitives.XYs.XY) return Vector_2D is
   begin
      return (Coordinates => XY);
   end Create_Vector_2D;

   ----------------------
   -- Create_Vector_2D --
   ----------------------

   function Create_Vector_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Vector_2D is
   begin
      return (Coordinates => Create_XY (X, Y));
   end Create_Vector_2D;

   ----------------------
   -- Create_Vector_2D --
   ----------------------

   function Create_Vector_2D
     (Point_1 : CGK.Primitives.Points_2D.Point_2D;
      Point_2 : CGK.Primitives.Points_2D.Point_2D) return Vector_2D is
   begin
      return
        (Coordinates => Points_2D.XY (Point_2) - Points_2D.XY (Point_1));
   end Create_Vector_2D;

   -----------
   -- Cross --
   -----------

   function Cross
     (Self : Vector_2D; Other : Vector_2D) return CGK.Reals.Real is
   begin
      return Cross_Product (Self.Coordinates, Other.Coordinates);
   end Cross;

   ---------
   -- Dot --
   ---------

   function Dot (Self : Vector_2D; Other : Vector_2D) return CGK.Reals.Real is
   begin
      return Dot_Product (Self.Coordinates, Other.Coordinates);
   end Dot;

   ---------------
   -- Magnitude --
   ---------------

   function Magnitude (Self : Vector_2D) return CGk.Reals.Real is
   begin
      return Modulus (Self.Coordinates);
   end Magnitude;

   ------------
   -- Normal --
   ------------

   function Normal (Self : Vector_2D) return Vector_2D is
   begin
      return (Coordinates => Create_XY (X => Y (Self), Y => -X (Self)));
   end Normal;

   -------
   -- X --
   -------

   function X (Self : Vector_2D) return CGK.Reals.Real is
   begin
      return X (Self.Coordinates);
   end X;

   --------
   -- XY --
   --------

   function XY (Self : Vector_2D) return CGK.Primitives.XYs.XY is
   begin
      return Self.Coordinates;
   end XY;

   -------
   -- Y --
   -------

   function Y (Self : Vector_2D) return CGK.Reals.Real is
   begin
      return Y (Self.Coordinates);
   end Y;

end CGK.Primitives.Vectors_2D;
