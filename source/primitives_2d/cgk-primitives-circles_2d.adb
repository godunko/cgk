--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body CGK.Primitives.Circles_2D is

   ------------
   -- Center --
   ------------

   function Center
     (Self : Circle_2D) return CGK.Primitives.Points_2D.Point_2D is
   begin
      return Self.Center;
   end Center;

   ----------------------
   -- Create_Circle_2D --
   ----------------------

   function Create_Circle_2D
     (Center : CGK.Primitives.Points_2D.Point_2D;
      Radius : CGK.Reals.Real) return Circle_2D is
   begin
      return (Center => Center, Radius => Radius);
   end Create_Circle_2D;

   ----------------------
   -- Create_Circle_2D --
   ----------------------

   function Create_Circle_2D
     (X      : CGK.Reals.Real;
      Y      : CGK.Reals.Real;
      Radius : CGK.Reals.Real) return Circle_2D is
   begin
      return
        (Center => CGK.Primitives.Points_2D.Create_Point_2D (X, Y),
         Radius => Radius);
   end Create_Circle_2D;

   ------------
   -- Radius --
   ------------

   function Radius (Self : Circle_2D) return CGK.Reals.Real is
   begin
      return Self.Radius;
   end Radius;

end CGK.Primitives.Circles_2D;
