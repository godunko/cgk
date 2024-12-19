--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Point in 2D cartesian space.

limited with CGK.Primitives.Transformations_2D;
limited with CGK.Primitives.Vectors_2D;
with CGK.Primitives.XYs;
limited with CGK.Reals;

package CGK.Primitives.Points_2D
  with Pure
is

   type Point_2D is private with Preelaborable_Initialization;

   function Create_Point_2D
     (X : CGK.Reals.Real; Y : CGK.Reals.Real) return Point_2D
     with Inline_Always;

   function Create_Point_2D
     (XY : CGK.Primitives.XYs.XY) return Point_2D with Inline;

   function X (Self : Point_2D) return CGK.Reals.Real with Inline;
   --  Returns X coordinate.

   function Y (Self : Point_2D) return CGK.Reals.Real with Inline;
   --  Returns Y coordinate.

   function XY (Self : Point_2D) return CGK.Primitives.XYs.XY with Inline;
   --  Returns two coordinates as pair of numbers.

   function Distance
     (Point_1 : Point_2D;
      Point_2 : Point_2D) return CGK.Reals.Real with Inline;
   --  Computes the distance between two points.

   function Is_Equal
     (Self             : Point_2D;
      Other            : Point_2D;
      Linear_Tolarance : CGK.Reals.Real) return Boolean;
   --  Returns True when distance between given points are less or equal to
   --  given linear tolerance.

   procedure Translate
     (Self   : in out Point_2D;
      Offset : CGK.Primitives.Vectors_2D.Vector_2D);
   --  Translate a point in the direction of the vector on vector's magnitude.

   procedure Transform
     (Self           : in out Point_2D;
      Transformation : CGK.Primitives.Transformations_2D.Transformation_2D);
   --  Transform point with given transformation.

private

   type Point_2D is record
      Coordinates : CGK.Primitives.XYs.XY;
   end record;

end CGK.Primitives.Points_2D;
