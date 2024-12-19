--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Advanced algorithms to create Direction_3D objects.

package CGK.Primitives.Directions_3D.Builders is

   pragma Pure;

   type Direction_3D_Builder is private;

   procedure Build
     (Self : in out Direction_3D_Builder; XYZ : CGK.Primitives.XYZs.XYZ);

   function Is_Valid (Self : Direction_3D_Builder) return Boolean with Inline;

   function Direction
     (Self : Direction_3D_Builder) return Direction_3D with Inline;

private

   type Direction_3D_Builder is record
      Valid  : Boolean := False;
      Result : Direction_3D;
   end record;

end CGK.Primitives.Directions_3D.Builders;
