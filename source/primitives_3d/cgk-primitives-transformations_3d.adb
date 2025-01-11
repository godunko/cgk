--
--  Copyright (C) 2024-2025, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

with CGK.Primitives.XYZs;
with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.Transformations_3D is

   use CGK.Mathematics.Matrices_3x3;
   use CGK.Mathematics.Vectors_3;
   use CGK.Reals;

   procedure Set_Rotation_X
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real);

   procedure Set_Rotation_Y
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real);

   procedure Set_Rotation_Z
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real);

   --  -----------------
   --  -- Is_Identity --
   --  -----------------
   --
   --  function Is_Identity (Self : Transformation_2D) return Boolean is
   --  begin
   --     return Self.Kind = Identity;
   --  end Is_Identity;
   --
   --  --------------------
   --  -- Is_Translation --
   --  --------------------
   --
   --  function Is_Translation (Self : Transformation_2D) return Boolean is
   --  begin
   --     return Self.Kind = Translation;
   --  end Is_Translation;

   --------------
   -- Multiply --
   --------------

   procedure Multiply
     (Self : in out Transformation_3D;
      By   : Transformation_3D) is
   begin
      if By.Kind = Identity then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self := By;

         when Translation =>
            case By.Kind is
               when Identity =>
                  null;

               when Translation =>
                  Self.Vector := @ + By.Vector;

               when Rotation =>
                  Self.Kind   := Complex;
                  Self.Matrix := By.Matrix;

               when Complex =>
                  Self.Matrix := By.Matrix;
                  Self.Vector := @ + By.Vector;
            end case;

         when Rotation =>
            case By.Kind is
               when Identity =>
                  null;

               when Translation =>
                  Self.Kind   := Complex;
                  Self.Vector := By.Vector;

               when Rotation =>
                  Self.Matrix := @ * By.Matrix;

               when Complex =>
                  Self.Kind   := Complex;
                  Self.Vector := Self.Matrix * By.Vector;
                  Self.Matrix := @ * By.Matrix;
            end case;

         when Complex =>
            case By.Kind is
               when Identity =>
                  null;

               when Translation =>
                  Self.Vector := @ + Self.Matrix * By.Vector;

               when Rotation =>
                  Self.Matrix := @ * By.Matrix;

               when Complex =>
                  Self.Vector := @ + Self.Matrix * By.Vector;
                  Self.Matrix := @ * By.Matrix;
            end case;
      end case;
   end Multiply;

   --------------
   -- Rotate_X --
   --------------

   procedure Rotate_X
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real)
   is
      Matrix : Matrix_3x3;

   begin
      if Angle = 0.0 then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self.Kind := Rotation;
            Set_Rotation_X (Self.Matrix, Angle);

         when Translation =>
            Self.Kind := Complex;
            Set_Rotation_X (Self.Matrix, Angle);

         when Rotation =>
            Set_Rotation_X (Matrix, Angle);
            Self.Matrix := @ * Matrix;

         when Complex =>
            Set_Rotation_X (Matrix, Angle);
            Self.Matrix := @ * Matrix;
      end case;
   end Rotate_X;

   --------------
   -- Rotate_Y --
   --------------

   procedure Rotate_Y
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real)
   is
      Matrix : Matrix_3x3;

   begin
      if Angle = 0.0 then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self.Kind := Rotation;
            Set_Rotation_Y (Self.Matrix, Angle);

         when Translation =>
            Self.Kind := Complex;
            Set_Rotation_Y (Self.Matrix, Angle);

         when Rotation =>
            Set_Rotation_Y (Matrix, Angle);
            Self.Matrix := @ * Matrix;

         when Complex =>
            Set_Rotation_Y (Matrix, Angle);
            Self.Matrix := @ * Matrix;
      end case;
   end Rotate_Y;

   --------------
   -- Rotate_Z --
   --------------

   procedure Rotate_Z
     (Self  : in out Transformation_3D;
      Angle : CGK.Reals.Real)
   is
      Matrix : Matrix_3x3;

   begin
      if Angle = 0.0 then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self.Kind := Rotation;
            Set_Rotation_Z (Self.Matrix, Angle);

         when Translation =>
            Self.Kind := Complex;
            Set_Rotation_Z (Self.Matrix, Angle);

         when Rotation =>
            Set_Rotation_Z (Matrix, Angle);
            Self.Matrix := @ * Matrix;

         when Complex =>
            Set_Rotation_Z (Matrix, Angle);
            Self.Matrix := @ * Matrix;
      end case;
   end Rotate_Z;

   ----------------------------
   -- Set_Denavit_Hartenberg --
   ----------------------------

   procedure Set_Denavit_Hartenberg
     (Self : out Transformation_3D;
      d    : CGK.Reals.Real;
      θ    : CGK.Reals.Real;
      r    : CGK.Reals.Real;
      α    : CGK.Reals.Real)
   is
      Sin_θ : constant CGK.Reals.Real := CGK.Reals.Elementary_Functions.Sin (θ);
      Cos_θ : constant CGK.Reals.Real := CGK.Reals.Elementary_Functions.Cos (θ);
      Sin_α : constant CGK.Reals.Real := CGK.Reals.Elementary_Functions.Sin (α);
      Cos_α : constant CGK.Reals.Real := CGK.Reals.Elementary_Functions.Cos (α);

   begin
      Self :=
        (Kind   => Complex,
         Matrix =>
           [[Cos_θ, -Sin_θ * Cos_α, Sin_θ * Sin_α],
            [Sin_θ, Cos_θ * Cos_α,  -Cos_θ * Sin_α],
            [0.0,   Sin_α,          Cos_α]],
         Vector =>
           [r * Cos_θ, r * Sin_θ,  d]);
      end Set_Denavit_Hartenberg;

   ------------------
   -- Set_Identity --
   ------------------

   procedure Set_Identity (Self : out Transformation_3D) is
   begin
      Self :=
        (Kind   => Identity,
         Matrix => CGK.Mathematics.Matrices_3x3.Identity,
         Vector => [others => 0.0]);
   end Set_Identity;

   --------------------
   -- Set_Rotation_X --
   --------------------

   procedure Set_Rotation_X
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real)
   is
      C : constant Real := CGK.Reals.Elementary_Functions.Cos (Angle);
      S : constant Real := CGK.Reals.Elementary_Functions.Sin (Angle);

   begin
      Matrix :=
        [0 => [0 => 1.0, 1 => 0.0, 2 => 0.0],
         1 => [0 => 0.0, 1 => C,   2 => -S],
         2 => [0 => 0.0, 1 => S, 2 => C]];
   end Set_Rotation_X;

   --------------------
   -- Set_Rotation_Y --
   --------------------

   procedure Set_Rotation_Y
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real)
   is
      C : constant Real := CGK.Reals.Elementary_Functions.Cos (Angle);
      S : constant Real := CGK.Reals.Elementary_Functions.Sin (Angle);

   begin
      Matrix :=
        [0 => [0 => C,   1 => 0.0, 2 => S],
         1 => [0 => 0.0, 1 => 1.0, 2 => 0.0],
         2 => [0 => -S,  1 => 0.0, 2 => C]];
   end Set_Rotation_Y;

   --------------------
   -- Set_Rotation_Z --
   --------------------

   procedure Set_Rotation_Z
     (Matrix : in out CGK.Mathematics.Matrices_3x3.Matrix_3x3;
      Angle  : CGK.Reals.Real)
   is
      C : constant Real := CGK.Reals.Elementary_Functions.Cos (Angle);
      S : constant Real := CGK.Reals.Elementary_Functions.Sin (Angle);

   begin
      Matrix :=
        [0 => [0 => C,   1 => -S,  2 => 0.0],
         1 => [0 => S,   1 => C,   2 => 0.0],
         2 => [0 => 0.0, 1 => 0.0, 2 => 1.0]];
   end Set_Rotation_Z;

   --------------------
   -- Set_Rotation_Z --
   --------------------

   procedure Set_Rotation_Z
     (Self  : out Transformation_3D;
      Angle : CGK.Reals.Real) is
   begin
      Self.Kind   := Rotation;
      Set_Rotation_Z (Self.Matrix, Angle);
      Self.Vector := [0.0, 0.0, 0.0];
   end Set_Rotation_Z;

   ---------------------
   -- Set_Translation --
   ---------------------

   procedure Set_Translation
     (Self   : out Transformation_3D;
      Offset : CGK.Primitives.XYZs.XYZ) is
   begin
      Self.Kind   := Translation;
      Set_Identity (Self.Matrix);
      Self.Vector := CGK.Primitives.XYZs.As_Vector_3 (Offset);
   end Set_Translation;

   ---------------
   -- Transform --
   ---------------

   function Transform
     (Self : Transformation_3D;
      Item : CGK.Mathematics.Vectors_3.Vector_3)
      return CGK.Mathematics.Vectors_3.Vector_3 is
   begin
      case Self.Kind is
         when Identity =>
            return Item;

         when Translation =>
            return Item + Self.Vector;

         when Rotation =>
            return Self.Matrix * Item;

         when Complex =>
            return Self.Matrix * Item + Self.Vector;
      end case;
   end Transform;

   ---------------
   -- Transform --
   ---------------

   function Transform
     (Self : Transformation_3D;
      Item : CGK.Primitives.XYZs.XYZ) return CGK.Primitives.XYZs.XYZ is
   begin
      return
        CGK.Primitives.XYZs.As_XYZ
          (Transform (Self, CGK.Primitives.XYZs.As_Vector_3 (Item)));
   end Transform;

   ---------------
   -- Translate --
   ---------------

   procedure Translate
     (Self   : in out Transformation_3D;
      Offset : CGK.Primitives.XYZs.XYZ)
   is
      Vector : constant Vector_3 := CGK.Primitives.XYZs.As_Vector_3 (Offset);

   begin
      if Vector (0) = 0.0 and Vector (1) = 0.0 and Vector (2) = 0.0 then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self.Kind   := Translation;
            Self.Vector := Vector;

         when Translation =>
            Self.Vector := @ + Vector;

         when Rotation =>
            Self.Kind   := Complex;
            Self.Vector := Vector;

         when Complex =>
            Self.Vector := @ + Self.Matrix * Vector;
      end case;
   end Translate;

   --  ---------------------------
   --  -- Translation_Component --
   --  ---------------------------
   --
   --  function Translation_Component
   --    (Self : Transformation_2D) return CGK.Primitives.XYs.XY is
   --  begin
   --     return To_XY (Self.Vector);
   --  end Translation_Component;

end CGK.Primitives.Transformations_3D;
