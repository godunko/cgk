--
--  Copyright (C) 2023-2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Point in 3D cartesian space.

pragma Ada_2022;

with CGK.Mathematics.Vectors_3;
with CGK.Primitives.Transformations_3D;
limited with CGK.Primitives.Vectors_3D;
with CGK.Primitives.XYZs;
with CGK.Reals;

package CGK.Primitives.Points_3D is

   pragma Pure;

   type Point_3D is private
     with Preelaborable_Initialization;

   function As_Point_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Point_3D with Inline;

   function As_Point_3D
     (Item : CGK.Primitives.XYZs.XYZ) return Point_3D with Inline;

   function As_Vector_3
     (Self : Point_3D) return CGK.Mathematics.Vectors_3.Vector_3 with Inline;

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

   procedure Transform
     (Self           : in out Point_3D;
      Transformation : CGK.Primitives.Transformations_3D.Transformation_3D);
   --  Transform point with given transformation.

private

   type Point_3D is new CGK.Mathematics.Vectors_3.Vector_3;

   function As_Point_3D
     (X : CGK.Reals.Real;
      Y : CGK.Reals.Real;
      Z : CGK.Reals.Real) return Point_3D is ([X, Y, Z]);

   function As_Point_3D
     (Item : CGK.Primitives.XYZs.XYZ) return Point_3D
        is (Point_3D (CGK.Primitives.XYZs.As_Vector_3 (Item)));

   function As_Vector_3
     (Self : Point_3D) return CGK.Mathematics.Vectors_3.Vector_3
        is (CGK.Mathematics.Vectors_3.Vector_3 (Self));

end CGK.Primitives.Points_3D;
