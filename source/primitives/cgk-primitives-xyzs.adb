--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

package body CGK.Primitives.XYZs is

   use CGK.Reals;

   ---------
   -- "+" --
   ---------

   function "+" (Left : XYZ; Right : XYZ) return XYZ is
   begin
      return (Left.X + Right.X, Left.Y + Right.Y, Left.Z + Right.Z);
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Left : XYZ; Right : XYZ) return XYZ is
   begin
      return (Left.X - Right.X, Left.Y - Right.Y, Left.Z - Right.Z);
   end "-";

   ----------------
   -- Create_XYZ --
   ----------------

   function Create_XYZ
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return XYZ is
   begin
      return (X => X, Y => Y, Z => Z);
   end Create_XYZ;

   -------------
   -- Set_XYZ --
   -------------

   procedure Set_XYZ
     (Self : out XYZ;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real;
      Z    : CGK.Reals.Real) is
   begin
      Self := (X, Y, Z);
   end Set_XYZ;

   -------
   -- X --
   -------

   function X (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self.X;
   end X;

   -------
   -- Y --
   -------

   function Y (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self.Y;
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self.Z;
   end Z;

end CGK.Primitives.XYZs;
