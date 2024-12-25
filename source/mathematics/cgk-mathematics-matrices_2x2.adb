--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

package body CGK.Mathematics.Matrices_2x2 is

   use type CGK.Reals.Real;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Matrix_2x2; Right : Matrix_2x2) return Matrix_2x2 is
   begin
      return
        [0 =>
           [0 => Left (0, 0) * Right (0, 0) + Left (0, 1) * Right (1, 0),
            1 => Left (0, 0) * Right (0, 1) + Left (0, 1) * Right (1, 1)],
         1 =>
           [0 => Left (1, 0) * Right (0, 0) + Left (1, 1) * Right (1, 0),
            1 => Left (1, 0) * Right (0, 1) + Left (1, 1) * Right (1, 1)]];
   end "*";

   ------------------
   -- Set_Identity --
   ------------------

   procedure Set_Identity (Self : out Matrix_2x2) is
   begin
      Self := [[1.0, 0.0], [0.0, 1.0]];
   end Set_Identity;

end CGK.Mathematics.Matrices_2x2;
