--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Transformation in 3D space.

pragma Ada_2022;

private with CGK.Mathematics.Matrices_3x3;
with CGK.Mathematics.Vectors_3;
limited with CGK.Primitives.XYZs;
with CGK.Reals;

package CGK.Primitives.Transformations_3D
  with Pure
is

   type Transformation_3D is private
     with Preelaborable_Initialization;

   function Transform
     (Self : Transformation_3D;
      Item : CGK.Primitives.XYZs.XYZ) return CGK.Primitives.XYZs.XYZ
        with Inline;

   function Transform
     (Self : Transformation_3D;
      Item : CGK.Mathematics.Vectors_3.Vector_3)
      return CGK.Mathematics.Vectors_3.Vector_3;

   --  function Is_Identity (Self : Transformation_2D) return Boolean
   --    with Inline_Always;
   --  --  Returns True when transformation is identity.
   --
   --  function Is_Translation (Self : Transformation_2D) return Boolean
   --    with Inline_Always;
   --  --  Returns True when transformation is translation only.
   --
   --  function Translation_Component
   --    (Self : Transformation_2D) return CGK.Primitives.XYs.XY with Inline;
   --  --  Returns translation component of the transformation.

   procedure Set_Identity (Self : out Transformation_3D);
   --  Set transformation to identity

   --  procedure Set_Translation
   --    (Self   : out Transformation_2D;
   --     Offset : CGK.Primitives.XYs.XY);
   --  --  Set transformation to translation by given vector.

   --  procedure Set_Rotation
   --    (Self  : out Transformation_2D;
   --     Angle : CGK.Reals.Real);
   --  --  Set transformation to rotate around origin of the coordinate system by
   --  --  given angle.
   --
   --  procedure Set_Rotation
   --    (Self  : out Transformation_2D;
   --     Point : CGK.Primitives.Points_2D.Point_2D;
   --     Angle : CGK.Reals.Real);
   --  --  Set transformation to rotate around given point by given angle.

   procedure Multiply
     (Self : in out Transformation_3D;
      By   : Transformation_3D);

   procedure Set_Denavit_Hartenberg
     (Self : out Transformation_3D;
      d    : CGK.Reals.Real;
      θ    : CGK.Reals.Real;
      r    : CGK.Reals.Real;
      α    : CGK.Reals.Real);
   --  Set transformation defined by Denavit-Hartenberg parameters.

   procedure Translate
     (Self   : in out Transformation_3D;
      Offset : CGK.Primitives.XYZs.XYZ);

   procedure Rotate_X
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real);
   --  Rotate about X-axis

   procedure Rotate_Y
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real);
   --  Rotate about Y-axis

   procedure Rotate_Z
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real);
   --  Rotate about Y-axis

private

   type Transformation_Kind is
     (Identity,
      Translation,
      Rotation,
      Complex);

   type Transformation_3D is record
      Kind   : Transformation_Kind                     := Identity;
      Matrix : CGK.Mathematics.Matrices_3x3.Matrix_3x3 :=
        [0 => [1.0, 0.0, 0.0], 1 => [0.0, 1.0, 0.0], 2 => [0.0, 0.0, 1.0]];
      Vector : CGK.Mathematics.Vectors_3.Vector_3      := [0.0, 0.0, 0.0];
   end record;

end CGK.Primitives.Transformations_3D;
