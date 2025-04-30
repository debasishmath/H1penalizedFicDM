		%%Ag.m%%

If one want to use nonhomogeneous boundary condition on dR.
size of AG matrix is (no of non boundary nodes )*no of all the nodes, this is due to the formulation. (Do mathematical formulation on the boundary parts)
UG contains nonzero entry at boundary node of dR as a boundary condition. If BC is constant then specify it directly as given. otherwise define some proper function.
vector F2 takes care of the extra contribution to load vector on RHS due to splitting method

 
		%%Elliptic.m%%
This is the main file of the programe.


		%%Eload.m%%
This file takes care of the Load vector F on the RHS.


	       %%Elstif.m%%
This is a function file to compute the stiffnes matrix of the Laplace operator.

		%%Error1.m%%
To compute the Error in the L2 and H1 norm.

		%%LNODS.m%%


		%%LVLSF.m%%
stands for LeVeL Set Function

		%%mat.m%%

		%%mat1.m%%

		%%Nodefix.m%%

		%%TSTIFM.m%%
stands for Total STIFness Matrix.(Including dR nodes)

 
