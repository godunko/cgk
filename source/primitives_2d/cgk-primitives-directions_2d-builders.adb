--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body CGK.Primitives.Directions_2D.Builders is

   use CGK.Primitives.Points_2D;
   use CGK.Primitives.XYs;
   use CGK.Reals;

   procedure Invalidate (Self : in out Direction_2D_Builder);
   --  Invalidate state.

   -----------
   -- Build --
   -----------

   procedure Build
     (Self : in out Direction_2D_Builder;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real) is
   begin
      Build (Self, Create_XY (X, Y));
   end Build;

   -----------
   -- Build --
   -----------

   procedure Build
     (Self : in out Direction_2D_Builder; XY : CGK.Primitives.XYs.XY)
   is
      D : constant Real := Modulus (XY);

   begin
      Invalidate (Self);

      if D <= Resolution then
         return;
      end if;

      Unchecked_Set (Self.Result, XY / D);
      Self.Valid := True;
   end Build;

   -----------
   -- Build --
   -----------

   procedure Build
     (Self : in out Direction_2D_Builder;
      From : CGK.Primitives.Points_2D.Point_2D;
      To   : CGK.Primitives.Points_2D.Point_2D) is
   begin
      Build (Self, XY (To) - XY (From));
   end Build;

   ---------------
   -- Direction --
   ---------------

   function Direction
     (Self : Direction_2D_Builder) return Direction_2D is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      return Self.Result;
   end Direction;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : in out Direction_2D_Builder) is
   begin
      Self.Valid := False;
   end Invalidate;

   --------------
   -- Is_Valid --
   --------------

   function Is_Valid (Self : Direction_2D_Builder) return Boolean is
   begin
      return Self.Valid;
   end Is_Valid;

end CGK.Primitives.Directions_2D.Builders;
