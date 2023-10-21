#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01B_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


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


xTicks=(Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog=(Table[{10^x,xLaTeX["10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog1=(Table[{10^x,xLaTeX["1\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog2=(Table[{2 10^x,xLaTeX["2\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog5=(Table[{5 10^x,xLaTeX["5\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;


xGrids=(Table[x,{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xGridsLog=(Flatten[Table[Table[{If[#2[[1]]<=(n 10^x)<=#2[[2]],(n 10^x),{}]},{n,1,9,1}],{x,#1[[1]],#1[[2]],#1[[3]]}]])&;


deltaB=Simplify[(1/(1-sstd)-1/(1-ssam))/(1/(1-sstd))]
deltaN=Simplify[((1-ssam)-(1-sstd))/(1-sstd)]


textStyle=(Style[#,FontFamily->"Noto Serif CJK SC",FontSize->9])&


fig1=Plot[Evaluate[{deltaB,deltaN}//.{sstd->0.4}],{ssam,0,1},PlotRange->{-2.1,1.1},
	PlotStyle->{Blue,Red},
	Epilog->{
		PointSize[0.015],Point[{{0.4,0}}],
		PointSize[0.01],White,Point[{{0.4,0}}]},
	Evaluate@xFigLabel["\\sigma","\\delta"],
	Evaluate@xFigTicks[{0,1,0.1},{2,1},{-2,1,0.5},{2,1}],
	PlotLegends->Placed[LineLegend[
		{textStyle["\:7531\:78c1\:573a\:5b9a\:4e49\:7684\:5316\:5b66\:4f4d\:79fb"],textStyle["\:7531\:9891\:7387\:5b9a\:4e49\:7684\:5316\:5b66\:4f4d\:79fb"]},
		LegendFunction->Panel,LegendLayout->"ReversedColumn"],{Left,Bottom}],
	GridLines->{xGrids[{0,1,0.1}],xGrids[{-2,1,0.25}]},
	Prolog->{Dashed,Thickness[0.003],Line[{{0.4,1},{0.4,-2}}]},
	Evaluate@xFigConfig]


fig={fig1}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
