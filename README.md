# Computational Geometry Kernel

Project structure
-----------------

Project is divided into few modules:

 * Mathematics: Low level mathematical operations that may have platform specific implemenation, for eaxmple with use of SIMD instructions.
 * Primitives: Geometric primitives (points, lines, etc.) and operations on them. Primitives is not a tagged types and contains basic geometrical information only.
 
 Mathematics
 -----------
 
 Provides `Vector_2` and `Matrix_2x2` objects and operations on them.
 
 Primitives
 ----------
 
 Few primitives in 2D space are provided: 
  * `Circle_2D`
  * `Direction_2D`
  * `Line_2D`
  * `Point_2D`
  * `Vector_2D`
  
There are few ways to construct primitive:
  * Use Create_<Primitive> function from package where primitive is defined. All construction subprograms allows to initialize object from basic information, and almost never raise exceptions (there is some exceptions, for instance, when Direction_2 object is created from two coordinates close to zero).
  * Use builder from the <Primitive>.Builders package. It provides advanced construction algoriphms for primitives. Builder can fail to construct primitive from the given information, however, it never raise exception during construction, but sets state to invalid. Application can check state and retrieve result primitive if it has been constructed or process error condition in application specific way.
  * Use Intersections package to compute intersections between two primitives. Like builder, intersector create object or report error, the mai difference is that intersector is able to create multiple objects at one operation.
  
The `Triangilations_2D` package provides triangulation algoriphm for simple polygons without holes.

The `Analytical_Intersections_2D` package provides algoriphms to compute intersection points between 2D primitives.

The `Transformations_2D` package provides transformations of points in 2D space - rotation, translation - and used for transformations of primitives.
