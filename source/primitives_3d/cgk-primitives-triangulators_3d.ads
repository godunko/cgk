--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Triangulation of a polygon in 3D space, without holes.

with CGK.Primitives.Points_3D.Containers;
private with CGK.Primitives.Triangulators_2D;

package CGK.Primitives.Triangulators_3D is

   pragma Preelaborate;

   type Vertex_Count is new Natural;
   subtype Vertex_Index is Vertex_Count range 1 .. Vertex_Count'Last;

   type Triangle_Count is new Natural;
   subtype Triangle_Index is Triangle_Count range 1 .. Triangle_Count'Last;

   type Triangulator_3D is private;

   procedure Clear (Self : in out Triangulator_3D);
   --  Clear all information.

   function Add_Polygon_Point
     (Self  : in out Triangulator_3D;
      Point : CGK.Primitives.Points_3D.Point_3D) return Vertex_Index;
   --  Adds a new point to the internal points pool. Returns the point's
   --  index.

   procedure Triangulate (Self : in out Triangulator_3D);
   --  Do triangulation.

   function Is_Valid (Self : Triangulator_3D) return Boolean;
   --  Returns True when object contains valid result of the triangulation.

   function Length (Self : Triangulator_3D) return Triangle_Count;

   procedure Triangle
     (Self  : Triangulator_3D;
      Index : Triangle_Index;
      A     : out Vertex_Index;
      B     : out Vertex_Index;
      C     : out Vertex_Index);

private

   type Triangulator_3D is record
      Valid        : Boolean := False;
      Points       : CGK.Primitives.Points_3D.Containers.Point_3D_Sequence;
      Triangulator : CGK.Primitives.Triangulators_2D.Triangulator_2D;
   end record;

end CGK.Primitives.Triangulators_3D;
