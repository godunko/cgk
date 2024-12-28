--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

package body CGK.Primitives.XYZs is

   use CGK.Mathematics.Vectors_3;

   ---------
   -- "+" --
   ---------

   function "+" (Left : XYZ; Right : XYZ) return XYZ is
   begin
      return XYZ (Vector_3 (Left) + Vector_3 (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Left : XYZ; Right : XYZ) return XYZ is
   begin
      return XYZ (Vector_3 (Left) - Vector_3 (Right));
   end "-";

   -------------
   -- Set_XYZ --
   -------------

   procedure Set_XYZ
     (Self : out XYZ;
      X    : CGK.Reals.Real;
      Y    : CGK.Reals.Real;
      Z    : CGK.Reals.Real) is
   begin
      Self := [X, Y, Z];
   end Set_XYZ;

   -------
   -- X --
   -------

   function X (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self (0);
   end X;

   -------
   -- Y --
   -------

   function Y (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self (1);
   end Y;

   -------
   -- Z --
   -------

   function Z (Self : XYZ) return CGK.Reals.Real is
   begin
      return Self (2);
   end Z;

end CGK.Primitives.XYZs;
