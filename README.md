# Learning-Metal

A project in the hopes of learning how a computer prints out graphics to its user. A task complicated but so far abstracted that it seems easy

## Making a basic triangle (01/10/2023)

A triangle is a very simple thing to compute and display as it only has three vertices. We are hard-coding the triangle with an array of float3 char representing the triangles x,y,z cooordinates. Because for now I want to do basic 2d shapes we leave the z at a constant 0. the length of the window is from -1 to 1 in both x and y. This makes it easy to make a traingle as I just, set the top as 1,0 and the other two edges as the botttom left and right.

Next I need to make a vertex buffer and also modify my function in the metal file to return the correct vertices on the screen.

This is the result

![nice triangle](Images/first_trianlge.png)
