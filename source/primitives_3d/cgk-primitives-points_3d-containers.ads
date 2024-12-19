--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Containers of Point_3D objects.

with CGK.Internals.Generic_Sequences;

package CGK.Primitives.Points_3D.Containers is

   pragma Preelaborate;

   type Point_3D_Offset is new Integer;
   subtype Point_3D_Count is Point_3D_Offset range 0 .. Point_3D_Offset'Last;
   subtype Point_3D_Index is Point_3D_Offset range 1 .. Point_3D_Offset'Last;

   package Point_3D_Sequences is
     new CGK.Internals.Generic_Sequences (Point_3D_Index, Point_3D);

   subtype Point_3D_Sequence is Point_3D_Sequences.Sequence;

end CGK.Primitives.Points_3D.Containers;
