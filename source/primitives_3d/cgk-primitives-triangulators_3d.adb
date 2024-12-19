--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Directions_3D.Builders;
with CGK.Primitives.Points_2D;
with CGK.Primitives.XYZs;
with CGK.Reals;

package body CGK.Primitives.Triangulators_3D is

   use CGK.Primitives.Directions_3D;
   use CGK.Primitives.Directions_3D.Builders;
   use CGK.Primitives.Points_2D;
   use CGK.Primitives.Points_3D;
   use CGK.Primitives.Points_3D.Containers;
   use CGK.Primitives.Triangulators_2D;
   use CGK.Primitives.XYZs;
   use CGK.Reals;

   procedure Invalidate (Self : in out Triangulator_3D);
   --  Invalidate state of the triangulator.

   procedure Compute_Plane_Normal_Vector
     (Self    : Triangulator_3D;
      Normal  : out Direction_3D;
      Success : out Boolean);
   --  Compute normal vector to polygon's plane.

   -----------------------
   -- Add_Polygon_Point --
   -----------------------

   function Add_Polygon_Point
     (Self  : in out Triangulator_3D;
      Point : CGK.Primitives.Points_3D.Point_3D) return Vertex_Index is
   begin
      Self.Points.Append (Point);

      return Vertex_Index (Self.Points.Last);
   end Add_Polygon_Point;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Triangulator_3D) is
   begin
      Invalidate (Self);
      Clear (Self.Triangulator);
      Self.Points.Clear;
   end Clear;

   ---------------------------------
   -- Compute_Plane_Normal_Vector --
   ---------------------------------

   procedure Compute_Plane_Normal_Vector
     (Self    : Triangulator_3D;
      Normal  : out Direction_3D;
      Success : out Boolean)
   is
      Previous : XYZs.XYZ := Points_3D.XYZ (Self.Points.Last_Element);
      Current  : XYZs.XYZ;
      Vector   : XYZs.XYZ;
      Builder  : Direction_3D_Builder;

   begin
      for Index in Self.Points.First .. Self.Points.Last loop
         Current := Points_3D.XYZ (Self.Points (Index));

         Vector :=
           @ + Create_XYZ
                 (Y (Previous) * Z (Current) - Z (Previous) * Y (Current),
                  Z (Previous) * X (Current) - X (Previous) * Z (Current),
                  X (Previous) * Y (Current) - Y (Previous) * X (Current));

         Previous := Current;
      end loop;

      Build (Builder, Vector);

      if Is_Valid (Builder) then
         Normal  := (Direction (Builder));
         Success := True;

      else
         Success := False;
      end if;
   end Compute_Plane_Normal_Vector;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : in out Triangulator_3D) is
   begin
      Self.Valid := False;
   end Invalidate;

   --------------
   -- Is_Valid --
   --------------

   function Is_Valid (Self : Triangulator_3D) return Boolean is
   begin
      return Self.Valid;
   end Is_Valid;

   ------------
   -- Length --
   ------------

   function Length (Self : Triangulator_3D) return Triangle_Count is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      return Triangle_Count (Length (Self.Triangulator));
   end Length;

   --------------
   -- Triangle --
   --------------

   procedure Triangle
     (Self  : Triangulator_3D;
      Index : Triangle_Index;
      A     : out Vertex_Index;
      B     : out Vertex_Index;
      C     : out Vertex_Index) is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      Triangle
        (Self.Triangulator,
         Triangulators_2D.Triangle_Index (Index),
         Triangulators_2D.Vertex_Index (A),
         Triangulators_2D.Vertex_Index (B),
         Triangulators_2D.Vertex_Index (C));
   end Triangle;

   -----------------
   -- Triangulate --
   -----------------

   procedure Triangulate (Self : in out Triangulator_3D) is
      Normal  : Direction_3D;
      Success : Boolean;
      Max     : Real;
      Index   : Triangulators_2D.Vertex_Index with Unreferenced;

   begin
      Invalidate (Self);

      if Self.Points.Length < 3 then
         --  Degenerate case.

         return;
      end if;

      Compute_Plane_Normal_Vector (Self, Normal, Success);

      if not Success then
         --  Degenerate case: polygon has zero area in each coordinate plane.

         return;
      end if;

      --  Detect coordinate axis with largest component of the normal to the
      --  polygon's plane and project all points to the 2D plane orthogonal
      --  to this axis.

      Max :=
        Real'Max (abs X (Normal), Real'Max (abs Y (Normal), abs Z (Normal)));

      Clear (Self.Triangulator);

      if Max = abs X (Normal) then
         for J in Self.Points.First .. Self.Points.Last loop
            Index :=
              Add_Polygon_Point
                (Self.Triangulator,
                 Create_Point_2D (Y (Self.Points (J)), Z (Self.Points (J))));
         end loop;

      elsif Max = abs Y (Normal) then
         for J in Self.Points.First .. Self.Points.Last loop
            Index :=
              Add_Polygon_Point
                (Self.Triangulator,
                 Create_Point_2D (X (Self.Points (J)), Z (Self.Points (J))));
         end loop;

      else
         for J in Self.Points.First .. Self.Points.Last loop
            Index :=
              Add_Polygon_Point
                (Self.Triangulator,
                 Create_Point_2D (X (Self.Points (J)), Y (Self.Points (J))));
         end loop;
      end if;

      Triangulate (Self.Triangulator);

      Self.Valid := Is_Valid (Self.Triangulator);
   end Triangulate;

end CGK.Primitives.Triangulators_3D;
