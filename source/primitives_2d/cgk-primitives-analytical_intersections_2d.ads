--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Analytical intersections of 2D primitives.

with CGK.Primitives.Circles_2D;
with CGK.Primitives.Lines_2D;
with CGK.Primitives.Points_2D.Containers;

package CGK.Primitives.Analytical_Intersections_2D is

   pragma Preelaborate;

   type Analytical_Intersection_2D is private;

   function Create_Intersection
     (Circle_1 : CGK.Primitives.Circles_2D.Circle_2D;
      Circle_2 : CGK.Primitives.Circles_2D.Circle_2D)
      return Analytical_Intersection_2D;

   procedure Intersect
     (Self   : in out Analytical_Intersection_2D;
      Line_1 : CGK.Primitives.Lines_2D.Line_2D;
      Line_2 : CGK.Primitives.Lines_2D.Line_2D);

   procedure Intersect
     (Self     : in out Analytical_Intersection_2D;
      Circle_1 : CGK.Primitives.Circles_2D.Circle_2D;
      Circle_2 : CGK.Primitives.Circles_2D.Circle_2D);

   procedure Intersect
     (Self   : in out Analytical_Intersection_2D;
      Line   : CGK.Primitives.Lines_2D.Line_2D;
      Circle : CGK.Primitives.Circles_2D.Circle_2D);

   function Is_Valid
     (Self : Analytical_Intersection_2D) return Boolean with Inline;
   --  Returns True when object contains valid data.

   function Is_Identical_Elements
     (Self : Analytical_Intersection_2D) return Boolean with Inline;
   --  Returns True when elements are identical.
   --
   --  @exception Invalid_State_Error

   function Is_Parallel_Elements
     (Self : Analytical_Intersection_2D) return Boolean with Inline;
   --  Returns True when elements are parallel.
   --
   --  @exception Invalid_State_Error

   function Is_Disjoint_Elements
     (Self : Analytical_Intersection_2D) return Boolean with Inline;
   --  Returns True when elements are disjoint.
   --
   --  @exception Invalid_State_Error

   function Length
     (Self : Analytical_Intersection_2D)
      return CGK.Primitives.Points_2D.Containers.Point_2D_Array_Count
        with Inline;
   --  Returns the number of intersection points.
   --
   --  @exception Invalid_State_Error

   function Point
     (Self  : Analytical_Intersection_2D;
      Index : CGK.Primitives.Points_2D.Containers.Point_2D_Array_Index)
      return CGK.Primitives.Points_2D.Point_2D with Inline;
   --  Returns the intersection point of given Index.
   --
   --  @exception Constraint_Error
   --  @exception Invalid_State_Error

   function Points
     (Self : Analytical_Intersection_2D)
      return CGK.Primitives.Points_2D.Containers.Point_2D_Array;
   --  Returns array of intersection points.
   --
   --  @exception Invalid_State_Error

private

   use CGK.Primitives.Points_2D.Containers;

   type Relations is
     (Invalid, Disjoint, Identical, Intersects, Touches, Overlaps, Contains);

   type Analytical_Intersection_2D is record
      Relation  : Relations            := Invalid;
      Parallel  : Boolean              := False;
      Length    : Point_2D_Array_Count := 0;
      Points    : Point_2D_Array (1 .. 4);
   end record;

end CGK.Primitives.Analytical_Intersections_2D;
