--
--  Copyright (C) 2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

package body CGK.Mathematics.Matrices_3x3 is

   use type CGK.Reals.Real;

   ---------
   -- "*" --
   ---------

   function "*"
     (Left : Matrix_3x3; Right : Matrix_3x3) return Matrix_3x3 is
   begin
      return
        [0 =>
           [0 =>
              Left (0, 0) * Right (0, 0)
                + Left (0, 1) * Right (1, 0)
                + Left (0, 2) * Right (2, 0),
            1 =>
              Left (0, 0) * Right (0, 1)
                + Left (0, 1) * Right (1, 1)
                + Left (0, 2) * Right (2, 1),
            2 =>
              Left (0, 0) * Right (0, 2)
                + Left (0, 1) * Right (1, 2)
                + Left (0, 2) * Right (2, 2)],
         1 =>
           [0 =>
              Left (1, 0) * Right (0, 0)
                + Left (1, 1) * Right (1, 0)
                + Left (1, 2) * Right (2, 0),
            1 =>
              Left (1, 0) * Right (0, 1)
                + Left (1, 1) * Right (1, 1)
                + Left (1, 2) * Right (2, 1),
            2 =>
              Left (1, 0) * Right (0, 2)
                + Left (1, 1) * Right (1, 2)
                + Left (1, 2) * Right (2, 2)],
         2 =>
           [0 =>
              Left (2, 0) * Right (0, 0)
                + Left (2, 1) * Right (1, 0)
                + Left (2, 2) * Right (2, 0),
            1 =>
              Left (2, 0) * Right (0, 1)
                + Left (2, 1) * Right (1, 1)
                + Left (2, 2) * Right (2, 1),
            2 =>
              Left (2, 0) * Right (0, 2)
                + Left (2, 1) * Right (1, 2)
                + Left (2, 2) * Right (2, 2)]];
   end "*";

   ------------------
   -- Set_Identity --
   ------------------

   procedure Set_Identity (Self : out Matrix_3x3) is
   begin
      Self := Identity;
   end Set_Identity;

end CGK.Mathematics.Matrices_3x3;
