#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


xLaTeX=(MaTeX[
	#1,Magnification->#2,
	"Preamble"->{"\\usepackage{siunitx}","\\usepackage{physics}","\\usepackage{upgreek}"}])&;


xLabelFont={FontColor->Black,FontFamily->"Latin Modern",FontSize->5}
xFigConfig={
	Frame->True,GridLines->Automatic,ImageSize->Automatic->300,
	FrameStyle->BlackFrame,PlotStyle->ColorData[10],BaseStyle->xLabelFont};
xFigTicks=(FrameTicks->{
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}],
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#4[[1]],#4[[2]]}]],0.5]},{x,#3[[1]],#3[[2]],#3[[3]]}]})&;
xFigLabel=(FrameLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8]})&;


deltaB=Simplify[(1/(1-sstd)-1/(1-ssam))/(1/(1-sstd))]
deltaN=Simplify[((1-ssam)-(1-sstd))/(1-sstd)]


Plot[Evaluate[deltaB//.{sstd->Table[x,{x,0.2,0.8,0.2}]}],{ssam,0,1},Evaluate@xFigConfig]
Plot[Evaluate[deltaN//.{sstd->Table[x,{x,0.2,0.8,0.2}]}],{ssam,0,1},Evaluate@xFigConfig]


MoleculePlot3D[Molecule[Entity["Chemical", "Ethylene"]]]
MoleculePlot[Molecule[Entity["Chemical", "Acetylene"]]]


(* ::Input:: *)
(*Entity["Chemical","Acetylene"]*)
