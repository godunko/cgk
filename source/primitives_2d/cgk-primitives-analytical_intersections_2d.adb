--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.Vectors_2D;
with CGK.Reals.Elementary_Functions;

package body CGK.Primitives.Analytical_Intersections_2D is

   use CGK.Primitives.Circles_2D;
   use CGK.Primitives.Lines_2D;
   use CGK.Primitives.Points_2D;
   use CGK.Primitives.Vectors_2D;
   use CGK.Reals;

   procedure Invalidate (Self : in out Analytical_Intersection_2D);
   --  Invalidate state of the object

   procedure Swap (A : in out Real; B : in out Real) with Inline;

   -------------------------
   -- Create_Intersection --
   -------------------------

   function Create_Intersection
     (Circle_1 : CGK.Primitives.Circles_2D.Circle_2D;
      Circle_2 : CGK.Primitives.Circles_2D.Circle_2D)
      return Analytical_Intersection_2D is
   begin
      return Result : Analytical_Intersection_2D do
         Intersect (Result, Circle_1, Circle_2);
      end return;
   end Create_Intersection;

   ---------------
   -- Intersect --
   ---------------

   procedure Intersect
     (Self   : in out Analytical_Intersection_2D;
      Line_1 : CGK.Primitives.Lines_2D.Line_2D;
      Line_2 : CGK.Primitives.Lines_2D.Line_2D)
   is
      A1,  B1,  C1  : Real;
      A2,  B2,  C2  : Real;
      AL1, BE1, GA1 : Real;
      AL2, BE2, GA2 : Real;
      Det           : Real;
      Rap           : Real;
      Denom         : Real;
      XS            : Real;
      YS            : Real;

   begin
      Invalidate (Self);

      Coefficients (Line_1, A1, B1, C1);
      Coefficients (Line_2, A2, B2, C2);

      Det := Real'Max (abs A1, Real'Max (abs A2, Real'Max (abs B1, abs B2)));

      if abs A1 = Det then
         AL1 := A1;
         BE1 := B1;
         GA1 := C1;
         AL2 := A2;
         BE2 := B2;
         GA2 := C2;

      elsif abs B1 = Det then
         AL1 := B1;
         BE1 := A1;
         GA1 := C1;
         AL2 := B2;
         BE2 := A2;
         GA2 := C2;

      elsif abs A2 = Det then
         AL1 := A2;
         BE1 := B2;
         GA1 := C2;
         AL2 := A1;
         BE2 := B1;
         GA2 := C1;

      else
         AL1 := B2;
         BE1 := A2;
         GA1 := C2;
         AL2 := B1;
         BE2 := A1;
         GA2 := C1;
      end if;

      Rap   := AL2 / AL1;
      Denom := BE2 - Rap * BE1;

      if abs Denom <= Real'Model_Epsilon then
         Self.Relation :=
           (if abs (GA2 - Rap * GA1) <= Real'Model_Epsilon
              then Identical else Disjoint);
         Self.Parallel := True;
         Self.Length   := 0;

      else
         Self.Relation := Intersects;
         Self.Parallel := False;
         Self.Length   := 1;

         XS := (BE1 * GA2 / AL1 - BE2 * GA1 / AL1) / Denom;
         YS := (Rap * GA1 - GA2) / Denom;

         if (abs A1 /= Det and abs B1 = Det)
           or (abs A1 /= Det and abs B1 /= Det and abs A2 /= Det)
         then
            Swap (XS, YS);
         end if;

         Self.Points (1) := Create_Point_2D (XS, YS);
      end if;
   end Intersect;

   ---------------
   -- Intersect --
   ---------------

   procedure Intersect
     (Self     : in out Analytical_Intersection_2D;
      Circle_1 : CGK.Primitives.Circles_2D.Circle_2D;
      Circle_2 : CGK.Primitives.Circles_2D.Circle_2D)
   is
      Dist : constant Real := Distance (Center (Circle_1), Center (Circle_2));
      R1   : constant Real := Radius (Circle_1);
      R2   : constant Real := Radius (Circle_2);
      Sum  : constant Real := R1 + R2;
      Dif  : constant Real := abs (R1 - R2);

   begin
      Invalidate (Self);

      if Dist <= Real'Model_Epsilon then
         --  Circles are parallel or identical, no intersection points

         Self.Relation :=
           (if Dif <= Real'Model_Epsilon then Identical else Contains);
         Self.Parallel := True;
         Self.Length   := 0;

      elsif Dist - Sum > Epsilon (Sum) then
         --  Circles are outside of each other, no intersection points

         Self.Relation := Disjoint;
         Self.Parallel := False;
         Self.Length   := 0;

      elsif abs (Dist - Sum) <= Epsilon (Sum) then
         --  Circles are exterious, single tangential point

         declare
            XS : constant Real :=
              (X (Center (Circle_1)) * R2 + X (Center (Circle_2)) * R1) / Sum;
            YS : constant Real :=
              (Y (Center (Circle_1)) * R2 + Y (Center (Circle_2)) * R1) / Sum;

         begin
            Self.Relation := Touches;
            Self.Parallel := False;
            Self.Length   := 1;

            Self.Points (1) := Create_Point_2D (XS, YS);
         end;

      elsif (Sum - Dist) > Epsilon (Sum)
               and (Dist - Dif) > Epsilon (Dist + Dif)
      then
         declare
            A   : constant CGK.Primitives.Vectors_2D.Vector_2D :=
              Create_Vector_2D (Center (Circle_1), Center (Circle_2));
            L   : Real;
            H   : Real;
            D   : Real;
            XS1 : Real;
            YS1 : Real;
            XS2 : Real;
            YS2 : Real;

         begin
            Self.Relation := Overlaps;
            Self.Parallel := False;
            Self.Length   := 2;

            L := (Dist * Dist + R1 * R1 - R2 * R2) / (2.0 * Dist);
            D := R1 * R1 - L * L;

            if D < 0.0 then
               L := (if L > 0.0 then R1 else -R1);
            end if;

            H := Elementary_Functions.Sqrt (R1 * R1 - L * L);

            XS1 := X (Center (Circle_1)) + L * X (A) / Dist - H * Y (A) / Dist;
            YS1 := Y (Center (Circle_1)) + L * Y (A) / Dist + H * X (A) / Dist;

            XS2 := X (Center (Circle_1)) + L * X (A) / Dist + H * Y (A) / Dist;
            YS2 := Y (Center (Circle_1)) + L * Y (A) / Dist - H * X (A) / Dist;

            Self.Points (1) := Create_Point_2D (XS1, YS1);
            Self.Points (2) := Create_Point_2D (XS2, YS2);
         end;

      elsif abs (Dist - Dif) <= Epsilon (Sum) then
          declare
            A  : CGK.Primitives.Vectors_2D.Vector_2D :=
              Create_Vector_2D (Center (Circle_1), Center (Circle_2));
            XS : Real;
            YS : Real;

         begin
            Self.Relation := Contains;
            Self.Parallel := False;
            Self.Length   := 1;

            if Radius (Circle_1) < Radius (Circle_2) then
               A := -A;
            end if;

            XS :=
              (X (Center (Circle_1)) * R2 - X (Center (Circle_2)) * R1)
                 / (R2 - R1);
            YS :=
              (Y (Center (Circle_1)) * R2 - Y (Center (Circle_2)) * R1)
                 / (R2 - R1);

            Self.Points (1) := Create_Point_2D (XS, YS);
         end;

      else
         Self.Relation := Contains;
         Self.Parallel := False;
         Self.Length   := 0;
      end if;
   end Intersect;

   ---------------
   -- Intersect --
   ---------------

   procedure Intersect
     (Self   : in out Analytical_Intersection_2D;
      Line   : CGK.Primitives.Lines_2D.Line_2D;
      Circle : CGK.Primitives.Circles_2D.Circle_2D)
   is
      A, B, C : Real;
      D, H    : Real;
      XS, YS  : Real;

   begin
      Invalidate (Self);

      Coefficients (Line, A, B, C);
      D := A * X (Center (Circle)) + B * Y (Center (Circle)) + C;

      if abs D - Radius (Circle) > Epsilon (Radius (Circle)) then
         --  No intersection

         Self.Relation := Disjoint;
         Self.Parallel := False;
         Self.Length   := 0;

      elsif abs (abs D - Radius (Circle)) <= Epsilon (Radius (Circle)) then
         --  Tangential, single intersection point

         Self.Relation := Touches;
         Self.Parallel := False;
         Self.Length   := 1;

         XS := X (Center (Circle)) - D * A;
         YS := Y (Center (Circle)) - D * B;

         Self.Points (1) := Create_Point_2D (XS, YS);

      else
         --  Two intersection points

         Self.Relation := Overlaps;
         Self.Parallel := False;
         Self.Length   := 2;

         H :=
           Elementary_Functions.Sqrt
             (Radius (Circle) * Radius (Circle) - D * D);

         XS := X (Center (Circle)) - D * A - H * B;
         YS := Y (Center (Circle)) - D * B + H * A;
         Self.Points (1) := Create_Point_2D (XS, YS);

         XS := X (Center (Circle)) - D * A + H * B;
         YS := Y (Center (Circle)) - D * B - H * A;
         Self.Points (2) := Create_Point_2D (XS, YS);
      end if;
   end Intersect;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : in out Analytical_Intersection_2D) is
   begin
      Self.Relation := Invalid;
      Self.Parallel := False;
   end Invalidate;

   --------------------------
   -- Is_Disjoint_Elements --
   --------------------------

   function Is_Disjoint_Elements
     (Self : Analytical_Intersection_2D) return Boolean is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      return Self.Relation = Disjoint;
   end Is_Disjoint_Elements;

   ---------------------------
   -- Is_Identical_Elements --
   ---------------------------

   function Is_Identical_Elements
     (Self : Analytical_Intersection_2D) return Boolean is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      return Self.Relation = Identical;
   end Is_Identical_Elements;

   --------------------------
   -- Is_Parallel_Elements --
   --------------------------

   function Is_Parallel_Elements
     (Self : Analytical_Intersection_2D) return Boolean is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      return Self.Parallel;
   end Is_Parallel_Elements;

   --------------
   -- Is_Valid --
   --------------

   function Is_Valid (Self : Analytical_Intersection_2D) return Boolean is
   begin
      return Self.Relation /= Invalid;
   end Is_Valid;

   ------------
   -- Length --
   ------------

   function Length
     (Self : Analytical_Intersection_2D)
      return CGK.Primitives.Points_2D.Containers.Point_2D_Array_Count is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      return Self.Length;
   end Length;

   -----------
   -- Point --
   -----------

   function Point
     (Self  : Analytical_Intersection_2D;
      Index : CGK.Primitives.Points_2D.Containers.Point_2D_Array_Index)
      return CGK.Primitives.Points_2D.Point_2D is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      if Self.Length < Index then
         raise Constraint_Error;
      end if;

      return Self.Points (Index);
   end Point;

   ------------
   -- Points --
   ------------

   function Points
     (Self : Analytical_Intersection_2D)
      return CGK.Primitives.Points_2D.Containers.Point_2D_Array is
   begin
      Assert_Invalid_State_Error (Self.Relation /= Invalid);

      return Self.Points (1 .. Self.Length);
   end Points;

   ----------
   -- Swap --
   ----------

   procedure Swap (A : in out Real; B : in out Real) is
      C : constant Real := A;

   begin
      A := B;
      B := C;
   end Swap;

end CGK.Primitives.Analytical_Intersections_2D;
