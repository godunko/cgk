--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Transformation in 2D space.

private with CGK.Mathematics.Matrices_2x2;
private with CGK.Mathematics.Vectors_2;
limited with CGK.Primitives.Points_2D;
limited with CGK.Primitives.XYs;
with CGK.Reals;

package CGK.Primitives.Transformations_2D
  with Pure
is

   type Transformation_2D is private
     with Preelaborable_Initialization;

   function Transform
     (Self : Transformation_2D;
      XY   : CGK.Primitives.XYs.XY) return CGK.Primitives.XYs.XY;

   function Is_Identity (Self : Transformation_2D) return Boolean
     with Inline_Always;
   --  Returns True when transformation is identity.

   function Is_Translation (Self : Transformation_2D) return Boolean
     with Inline_Always;
   --  Returns True when transformation is translation only.

   function Translation_Component
     (Self : Transformation_2D) return CGK.Primitives.XYs.XY with Inline;
   --  Returns translation component of the transformation.

   procedure Set_Identity (Self : out Transformation_2D);
   --  Set transformation to identity

   procedure Set_Translation
     (Self   : out Transformation_2D;
      Offset : CGK.Primitives.XYs.XY);
   --  Set transformation to translation by given vector.

   procedure Set_Rotation
     (Self  : out Transformation_2D;
      Angle : CGK.Reals.Real);
   --  Set transformation to rotate around origin of the coordinate system by
   --  given angle.

   procedure Set_Rotation
     (Self  : out Transformation_2D;
      Point : CGK.Primitives.Points_2D.Point_2D;
      Angle : CGK.Reals.Real);
   --  Set transformation to rotate around given point by given angle.

   procedure Multiply
     (Self : in out Transformation_2D;
      By   : Transformation_2D);

   procedure Translate
     (Self   : in out Transformation_2D;
      Offset : CGK.Primitives.XYs.XY);

   procedure Rotate
     (Self  : in out Transformation_2D;
      Angle : CGK.Reals.Real);

private

   type Transformation_Kind is
     (Identity,
      Translation,
      Rotation,
      Complex);

   type Transformation_2D is record
      Kind   : Transformation_Kind                     := Identity;
      Matrix : CGK.Mathematics.Matrices_2x2.Matrix_2x2 :=
        [0 => [1.0, 0.0], 1 => [0.0, 1.1]];
      Vector : CGK.Mathematics.Vectors_2.Vector_2      := [0.0, 0.0];
   end record;

end CGK.Primitives.Transformations_2D;
