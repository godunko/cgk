--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.Directions_3D.Builders is

   use CGK.Primitives.XYZs;
   use CGK.Reals;
   use CGK.Reals.Elementary_Functions;

   procedure Invalidate (Self : in out Direction_3D_Builder);
   --  Invalidate state.

   -----------
   -- Build --
   -----------

   procedure Build
     (Self : in out Direction_3D_Builder; XYZ : CGK.Primitives.XYZs.XYZ)
   is
      AX : constant Real := X (XYZ);
      AY : constant Real := Y (XYZ);
      AZ : constant Real := Z (XYZ);
      D  : constant Real := Sqrt (AX * AX + AY * AY + AZ * AZ);

   begin
      Invalidate (Self);

      if D <= Resolution then
         return;
      end if;

      Unchecked_Set (Self.Result, AX / D, AY / D, AZ / D);
      Self.Valid  := True;
   end Build;

   ---------------
   -- Direction --
   ---------------

   function Direction
     (Self : Direction_3D_Builder) return Direction_3D is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      return Self.Result;
   end Direction;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : in out Direction_3D_Builder) is
   begin
      Self.Valid := False;
   end Invalidate;

   --------------
   -- Is_Valid --
   --------------

   function Is_Valid (Self : Direction_3D_Builder) return Boolean is
   begin
      return Self.Valid;
   end Is_Valid;

end CGK.Primitives.Directions_3D.Builders;
