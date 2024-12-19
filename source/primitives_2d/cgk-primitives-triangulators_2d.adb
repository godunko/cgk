--
--  Copyright (C) 2023, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with CGK.Primitives.XYs;
with CGK.Reals;

package body CGK.Primitives.Triangulators_2D is

   use CGK.Primitives.XYs;
   use CGK.Reals;

   type Winding_Direction is (Left, Right);

   --  Sequence of Point_2D indices

   package Point_2D_Array_Index_Sequences is
     new CGK.Internals.Generic_Sequences
           (Positive, Point_2D_Array_Index);

   subtype Point_2D_Array_Index_Sequence is
     Point_2D_Array_Index_Sequences.Sequence;

   function Can_Cut
     (Points    : Point_2D_Sequence;
      Verticies : Point_2D_Array_Index_Sequence;
      Previous  : Positive;
      Current   : Positive;
      Next      : Positive) return Boolean;

   function Inside
     (A : XYs.XY; B : XYs.XY; C : XYs.XY; P : XYs.XY) return Boolean;
   --  Check whether P is inside of triangle ABC.

   function Detect_Winding
     (Points : Point_2D_Sequence'Class) return Winding_Direction;
   --  Return winding of the given polygon.

   procedure Invalidate (Self : in out Triangulator_2D);

   -----------------------
   -- Add_Polygon_Point --
   -----------------------

   function Add_Polygon_Point
     (Self  : in out Triangulator_2D;
      Point : CGK.Primitives.Points_2D.Point_2D) return Vertex_Index is
   begin
      Self.Points.Append (Point);

      return Vertex_Index (Self.Points.Last);
   end Add_Polygon_Point;

   -------------
   -- Can_Cut --
   -------------

   function Can_Cut
     (Points    : Point_2D_Sequence;
      Verticies : Point_2D_Array_Index_Sequence;
      Previous  : Positive;
      Current   : Positive;
      Next      : Positive) return Boolean
   is
      A : constant XYs.XY := Points_2D.XY (Points (Verticies (Previous)));
      B : constant XYs.XY := Points_2D.XY (Points (Verticies (Current)));
      C : constant XYs.XY := Points_2D.XY (Points (Verticies (Next)));

   begin
      if (X (B) - X (A)) * (Y (C) - Y (A)) - (Y (B) - Y (A)) * (X (C) - X (A))
            < Resolution
      then
         return False;
      end if;

      for J in Verticies.First .. Verticies.Last loop
         if J /= Previous and J /= Current and J /= Next then
            declare
               P : constant XYs.XY := Points_2D.XY (Points (Verticies (J)));

            begin
               if Inside (A, B, C, P) then
                  return False;
               end if;
            end;
         end if;
      end loop;

      return True;
   end Can_Cut;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Triangulator_2D) is
   begin
      Invalidate (Self);
      Self.Points.Clear;
      Self.Result.Clear;
   end Clear;

   --------------------
   -- Detect_Winding --
   --------------------

   function Detect_Winding
     (Points : Point_2D_Sequence'Class) return Winding_Direction
   is
      --  Compute polygon's signed area. If it is negative, the polygon is
      --  right-winding.

      Area     : Real   := 0.0;
      Previous : XYs.XY := Points_2D.XY (Points.Last_Element);
      Current  : XYs.XY;

   begin
      for Index in Points.First .. Points.Last loop
         Current  := Points_2D.XY (Points (Index));
         Area     :=
           @ + X (Previous) * Y (Current) - Y (Previous) * X (Current);
         Previous := Current;
      end loop;

      return (if Area >= 0.0 then Left else Right);
   end Detect_Winding;

   ------------
   -- Inside --
   ------------

   function Inside
     (A : XYs.XY; B : XYs.XY; C : XYs.XY; P : XYs.XY) return Boolean
   is
      AX  : constant Real := X (C) - X (B);
      AY  : constant Real := Y (C) - Y (B);
      BX  : constant Real := X (A) - X (C);
      BY  : constant Real := Y (A) - Y (C);
      CX  : constant Real := X (B) - X (A);
      CY  : constant Real := Y (B) - Y (A);
      APX : constant Real := X (P) - X (A);
      APY : constant Real := Y (P) - Y (A);
      BPX : constant Real := X (P) - X (B);
      BPY : constant Real := Y (P) - Y (B);
      CPX : constant Real := X (P) - X (C);
      CPY : constant Real := Y (P) - Y (C);
      ABP : constant Real := AX * BPY - AY * BPX;
      CAP : constant Real := CX * APY - CY * APX;
      BCP : constant Real := BX * CPY - BY * CPX;

   begin
      return ABP >= 0.0 and CAP >= 0.0 and BCP >= 0.0;
   end Inside;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : in out Triangulator_2D) is
   begin
      Self.Valid := False;
   end Invalidate;

   --------------
   -- Is_Valid --
   --------------

   function Is_Valid (Self : Triangulator_2D) return Boolean is
   begin
      return Self.Valid;
   end Is_Valid;

   ------------
   -- Length --
   ------------

   function Length (Self : Triangulator_2D) return Triangle_Count is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      return Self.Result.Length;
   end Length;

   --------------
   -- Triangle --
   --------------

   procedure Triangle
     (Self  : Triangulator_2D;
      Index : Triangle_Index;
      A     : out Vertex_Index;
      B     : out Vertex_Index;
      C     : out Vertex_Index) is
   begin
      Assert_Invalid_State_Error (Self.Valid);

      A := Self.Result (Index).A;
      B := Self.Result (Index).B;
      C := Self.Result (Index).C;
   end Triangle;

   -----------------
   -- Triangulate --
   -----------------

   procedure Triangulate (Self : in out Triangulator_2D) is
      Verticies : Point_2D_Array_Index_Sequence;
      Previous  : Positive;
      Current   : Positive;
      Next      : Positive;
      Count     : Natural;

   begin
      Invalidate (Self);
      Self.Result.Clear;

      --  Order verticies in necessary direction.

      Verticies.Set_Capacity (Positive (Self.Points.Length));

      case Detect_Winding (Self.Points) is
         when Left =>
            for J in Self.Points.First .. Self.Points.Last loop
               Verticies.Append (J);
            end loop;

         when Right =>
            for J in reverse Self.Points.First .. Self.Points.Last loop
               Verticies.Append (J);
            end loop;
      end case;

      --  Main loop

      Current := Verticies.Last;
      Count   := 2 * Verticies.Length;

      while Verticies.Length > 2 loop
         --  Non simple polygon has been detected.

         if Count = 0 then
            Self.Result.Clear;

            return;
         end if;

         Count := @ - 1;

         --  Compute indicies of three consecutive verticies

         Previous := Current;

         if Previous > Verticies.Last then
            Previous := Verticies.First;
         end if;

         Current := @ + 1;

         if Current > Verticies.Last then
            Current := Verticies.First;
         end if;

         Next := Current + 1;

         if Next > Verticies.Last then
            Next := Verticies.First;
         end if;

         if Can_Cut (Self.Points, Verticies, Previous, Current, Next) then
            Self.Result.Append
              ((Vertex_Count (Verticies (Previous)),
                Vertex_Count (Verticies (Current)),
                Vertex_Count (Verticies (Next))));

            Verticies.Delete (Current);

            Count := 2 * Verticies.Length;
         end if;
      end loop;

      Self.Valid := True;
   end Triangulate;

end CGK.Primitives.Triangulators_2D;
