--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Points_2D;
with CGK.Primitives.XYs.Internals;
with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.Transformations_2D is

   use CGK.Mathematics.Matrices_2x2;
   use CGK.Mathematics.Vectors_2;
   use CGK.Primitives.XYs.Internals;
   use CGK.Reals;

   procedure Set_Rotation
     (Matrix : in out CGK.Mathematics.Matrices_2x2.Matrix_2x2;
      Angle  : CGK.Reals.Real);

   -----------------
   -- Is_Identity --
   -----------------

   function Is_Identity (Self : Transformation_2D) return Boolean is
   begin
      return Self.Kind = Identity;
   end Is_Identity;

   --------------------
   -- Is_Translation --
   --------------------

   function Is_Translation (Self : Transformation_2D) return Boolean is
   begin
      return Self.Kind = Translation;
   end Is_Translation;

   --------------
   -- Multiply --
   --------------

   procedure Multiply
     (Self : in out Transformation_2D;
      By   : Transformation_2D) is
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

   ------------
   -- Rotate --
   ------------

   procedure Rotate
     (Self  : in out Transformation_2D;
      Angle : CGK.Reals.Real)
   is
      Matrix : Matrix_2x2;

   begin
      if Angle = 0.0 then
         return;
      end if;

      case Self.Kind is
         when Identity =>
            Self.Kind := Rotation;
            Set_Rotation (Self.Matrix, Angle);

         when Translation =>
            Self.Kind := Complex;
            Set_Rotation (Self.Matrix, Angle);

         when Rotation =>
            Set_Rotation (Matrix, Angle);
            Self.Matrix := @ * Matrix;

         when Complex =>
            Set_Rotation (Matrix, Angle);
            Self.Matrix := @ * Matrix;
      end case;
   end Rotate;

   ------------------
   -- Set_Identity --
   ------------------

   procedure Set_Identity (Self : out Transformation_2D) is
   begin
      Self.Kind   := Identity;
      Set_Identity (Self.Matrix);
      Self.Vector := [others => 0.0];
   end Set_Identity;

   ------------------
   -- Set_Rotation --
   ------------------

   procedure Set_Rotation
     (Matrix : in out CGK.Mathematics.Matrices_2x2.Matrix_2x2;
      Angle  : CGK.Reals.Real)
   is
      use CGK.Reals.Elementary_Functions;

      C : constant Real := Cos (Angle);
      S : constant Real := Sin (Angle);

   begin
      Matrix :=
        [0 => [0 => C, 1 => -S],
         1 => [0 => S, 1 => C]];
   end Set_Rotation;

   ------------------
   -- Set_Rotation --
   ------------------

   procedure Set_Rotation
     (Self  : out Transformation_2D;
      Angle : CGK.Reals.Real) is
   begin
      Self.Kind   := Rotation;
      Set_Rotation (Self.Matrix, Angle);
      Self.Vector := [0.0, 0.0];
   end Set_Rotation;

   ------------------
   -- Set_Rotation --
   ------------------

   procedure Set_Rotation
     (Self  : out Transformation_2D;
      Point : CGK.Primitives.Points_2D.Point_2D;
      Angle : CGK.Reals.Real)
   is
      use CGK.Primitives.Points_2D;

      Vector : constant Vector_2 := To_Vector_2 (XY (Point));

   begin
      Self.Kind   := Complex;
      Set_Rotation (Self.Matrix, Angle);
      Self.Vector := -Vector;
      Self.Vector := Self.Matrix * @;
      Self.Vector := @ + Vector;
   end Set_Rotation;

   ---------------------
   -- Set_Translation --
   ---------------------

   procedure Set_Translation
     (Self   : out Transformation_2D;
      Offset : CGK.Primitives.XYs.XY) is
   begin
      Self.Kind   := Translation;
      Set_Identity (Self.Matrix);
      Self.Vector := To_Vector_2 (Offset);
   end Set_Translation;

   ---------------
   -- Transform --
   ---------------

   function Transform
     (Self : Transformation_2D;
      XY   : CGK.Primitives.XYs.XY) return CGK.Primitives.XYs.XY
   is
      use CGK.Primitives.XYs;

   begin
      case Self.Kind is
         when Identity =>
            return XY;

         when Translation =>
            return To_XY (To_Vector_2 (XY) + Self.Vector);

         when Rotation =>
            return To_XY (Self.Matrix * To_Vector_2 (XY));

         when Complex =>
            return To_XY (Self.Matrix * To_Vector_2 (XY) + Self.Vector);
      end case;
   end Transform;

   ---------------
   -- Translate --
   ---------------

   procedure Translate
     (Self   : in out Transformation_2D;
      Offset : CGK.Primitives.XYs.XY)
   is
      Vector : constant Vector_2 := To_Vector_2 (Offset);

   begin
      if Vector (0) = 0.0 and Vector (1) = 0.0 then
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

   ---------------------------
   -- Translation_Component --
   ---------------------------

   function Translation_Component
     (Self : Transformation_2D) return CGK.Primitives.XYs.XY is
   begin
      return To_XY (Self.Vector);
   end Translation_Component;

end CGK.Primitives.Transformations_2D;
