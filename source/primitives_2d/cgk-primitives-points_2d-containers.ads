--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Containers of Point_2D objects.

--  with CGK.Internals.Generic_Sequences;

package CGK.Primitives.Points_2D.Containers is

   pragma Preelaborate;

   type Point_2D_Array_Offset is new Integer;
   subtype Point_2D_Array_Count is
     Point_2D_Array_Offset range 0 .. Point_2D_Array_Offset'Last;
   subtype Point_2D_Array_Index is
     Point_2D_Array_Offset range 1 .. Point_2D_Array_Offset'Last;

   type Point_2D_Array is array (Point_2D_Array_Index range <>) of Point_2D;

   --  package Point_2D_Sequences is
   --    new CGK.Internals.Generic_Sequences (Point_2D_Array_Index, Point_2D);
   --
   --  subtype Point_2D_Sequence is Point_2D_Sequences.Sequence;

end CGK.Primitives.Points_2D.Containers;
