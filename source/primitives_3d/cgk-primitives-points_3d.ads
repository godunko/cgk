--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Point in 3D cartesian space.

limited with CGK.Primitives.Vectors_3D;
with CGK.Primitives.XYZs;
with CGK.Reals;

package CGK.Primitives.Points_3D is

   pragma Pure;

   type Point_3D is private;

   function Create_Point_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Point_3D with Inline;

   function Create_Point_3D
     (XYZ : CGK.Primitives.XYZs.XYZ) return Point_3D with Inline;

   function X (Self : Point_3D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Point_3D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function Z (Self : Point_3D) return CGK.Reals.Real with Inline;
   --  Returns Z coordinate.

   function XYZ (Self : Point_3D) return CGK.Primitives.XYZs.XYZ with Inline;
   --  Returns three coordinates of the point as tuple of numbers.

   function "+"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D)
      return Point_3D with Inline;

   function "-"
     (Left  : Point_3D;
      Right : CGK.Primitives.Vectors_3D.Vector_3D)
      return Point_3D with Inline;

private

   type Point_3D is new CGK.Primitives.XYZs.XYZ;

end CGK.Primitives.Points_3D;
