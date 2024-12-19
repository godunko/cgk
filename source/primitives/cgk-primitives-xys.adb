--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.XYs is

   use CGK.Mathematics.Vectors_2;
   use CGK.Reals;
   use CGK.Reals.Elementary_Functions;

   ---------
   -- "*" --
   ---------

   function "*" (Left : XY; Right : CGK.Reals.Real) return XY is
   begin
      return XY (Vector_2 (Left) * Right);
   end "*";

   ---------
   -- "*" --
   ---------

   function "*" (Left : CGK.Reals.Real; Right : XY) return XY is
   begin
      return XY (Left * Vector_2 (Right));
   end "*";

   ---------
   -- "+" --
   ---------

   function "+" (Left : XY; Right : XY) return XY is
   begin
      return XY (Vector_2 (Left) + Vector_2 (Right));
   end "+";

   ---------
   -- "-" --
   ---------

   function "-" (Self : XY) return XY is
   begin
      return XY (-Vector_2 (Self));
   end "-";

   ---------
   -- "-" --
   ---------

   function "-" (Left : XY; Right : XY) return XY is
   begin
      return XY (Vector_2 (Left) - Vector_2 (Right));
   end "-";

   ---------
   -- "/" --
   ---------

   function "/" (Left : XY; Right : CGK.Reals.Real) return XY is
   begin
      return XY (Vector_2 (Left) / Right);
   end "/";

   ---------------
   -- Create_XY --
   ---------------

   function Create_XY (X : CGK.Reals.Real; Y : CGK.Reals.Real) return XY is
   begin
      return [X, Y];
   end Create_XY;

   -------------------
   -- Cross_Product --
   -------------------

   function Cross_Product
     (Self : XY; Other : XY) return CGK.Reals.Real is
   begin
      return Self (0) * Other (1) - Self (1) * Other (0);
   end Cross_Product;

   -----------------
   -- Dot_Product --
   -----------------

   function Dot_Product
     (Self : XY; Other : XY) return CGK.Reals.Real is
   begin
      return Self (0) * Other (0) + Self (1) * Other (1);
   end Dot_Product;

   -------------
   -- Modulus --
   -------------

   function Modulus (Self : XY) return CGK.Reals.Real is
   begin
      return Sqrt (Self (0) * Self (0) + Self (1) * Self (1));
   end Modulus;

   -------
   -- X --
   -------

   function X (Self : XY) return CGK.Reals.Real is
   begin
      return Self (0);
   end X;

   -------
   -- Y --
   -------

   function Y (Self : XY) return CGK.Reals.Real is
   begin
      return Self (1);
   end Y;

end CGK.Primitives.XYs;
