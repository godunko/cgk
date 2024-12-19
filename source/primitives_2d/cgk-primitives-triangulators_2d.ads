--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Triangulation of a polygon in 2D space, without holes.

private with CGK.Internals.Generic_Sequences;
with CGK.Primitives.Points_2D;
private with CGK.Primitives.Points_2D.Containers;

package CGK.Primitives.Triangulators_2D is

   pragma Preelaborate;

   type Vertex_Count is new Natural;
   subtype Vertex_Index is Vertex_Count range 1 .. Vertex_Count'Last;

   type Triangle_Count is new Natural;
   subtype Triangle_Index is Triangle_Count range 1 .. Triangle_Count'Last;

   type Triangulator_2D is private;

   procedure Clear (Self : in out Triangulator_2D);

   function Add_Polygon_Point
     (Self  : in out Triangulator_2D;
      Point : CGK.Primitives.Points_2D.Point_2D) return Vertex_Index;

   procedure Triangulate (Self : in out Triangulator_2D);

   function Is_Valid (Self : Triangulator_2D) return Boolean;

   function Length (Self : Triangulator_2D) return Triangle_Count;

   procedure Triangle
     (Self  : Triangulator_2D;
      Index : Triangle_Index;
      A     : out Vertex_Index;
      B     : out Vertex_Index;
      C     : out Vertex_Index);

private

   use CGK.Primitives.Points_2D.Containers;

   type Triangle_Record is record
      A : Vertex_Index;
      B : Vertex_Index;
      C : Vertex_Index;
   end record;

   package Triangle_Sequences is
     new CGK.Internals.Generic_Sequences (Triangle_Index, Triangle_Record);

   type Triangulator_2D is record
      Points : Point_2D_Sequence;
      Valid  : Boolean := False;
      Result : Triangle_Sequences.Sequence;
   end record;

end CGK.Primitives.Triangulators_2D;
