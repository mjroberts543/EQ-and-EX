# EQ-and-EX

# Overview:  
  This repository concerns time series analysis for the discrimination of natural earthquakes from mining explosions in Arizona and Nevada. In particular, I aim to incorporate a "clustering" algorithm PaLD into the algorithm. The vast majority of this code was written before PaLD was publicly available as a package in R, so that section of the code was written through my research concerning the paper [*A social perspective on perceived distances reveals deep community structure*](https://www.pnas.org/doi/full/10.1073/pnas.2003634119).  
  
  
# Partitioned local depth:  
  The idea of using partitioned local depth is relatively new to the scene of data analysis. The general idea is to realize a structure on a graph of vertices $S=$ { $s_1,s_2,\ldots,s_n$ }, based on an underlying distance metric $d$ that informs the "decisions" of each vertex. The individuals form alliances by being more likely to support their neighbors than further away competitors. The applications of PaLD vary from linguistics, genetics, and cultural psychology to, of course, seismic event classification.  

Informally, we can define the *conflict focus* $U_{x,y}$ as the set of individuals whose allegiance is being sought by competitors $x$ and $y$. Mathematically, this is the set of vertices that are as close to either $x$ or $y$ as $x$ and $y$ are to one another, or
$$U_{x,y}= [z\in S| d(z,x) \leq d(y,x) \hbox{  or  } d(z,y)\leq d(x,y) ].$$ 

This conflict focus allows for the contrasting of the influence of points $x$ and $y$ over their neighbors. By comparing how influential each point is, they can be ranked based on their power in the community. This level of influence is referred to as *local (community) depth*. The paper above specifically defines the local depth of a vertex $l_s(x)$ as the probability that a randomly selected point $Z$ supports the vertex $x$ over another randomly selected opposing point $Y$, with ties determined by a coin toss, through
$$l_s(x)=P(d(Z,x)\lt d(Z,Y)+P(d(Z,x)=d(Z,Y))/2.$$

Further, the local depth is partitioned through the concept of the *cohesion* of vertices $x$ and $w$. The strength of the connection between these vertices is determined through how likely $w$ is to defend $x$ in conflicts, which gives pair-wise social cohesion
$$C_{x,w}=P(Z=w \hbox{  and  } d(Z,x)\lt d(Z,Y)).$$
Taking the partitions of the graph to be those that are "strongly" tied through cohesion symmetrically, we can create a way to split data points into clusters, notably, without specifying the number of clusters beforehand. However, in this repository, I am primarily concerned with two specific classifications, earthquakes and explosions, so that property of PaLD is only tangentially useful. Potentially, it may be used to classify other sources of seismic
signals as well like volcanic seismicity and tides-related seismic noise.


# Datasets:  
  The data used in this repository come from a collection of multiple earthquakes and explosions recorded with various seimograms in Arizona and Nevada. Each is limited to only the z-component, representing vertical displacement. We downloaded the broadband vertical component seismograms from the Incorporated Research Institutions for Seismology Data Management Centers (IRIS DMC). We then used the Seismic Analysis Code (SAC) software to remove the instruments response of the seismometer. Collecting the data was done by my coauthors on an upcoming paper.
  
  

# Challenges:  
  There are two primary challenges in classification. First, in order to use PaLD, a "distance" between points is required. My approach is to define the distance between two time series through using one as a filter of the other. In essence, the first time series is cut into a window of N samples and then is slid across the other. The number of times the time series cross each other is then recorded and the maximum number of crossings is converted into a distance. This takes into account the concern that the data may not have been perfectly aligned -- after all, when does an earthquake really start?   
  
  The second challenge is that there is not very much data, only about 40 earthquakes and 60 explosions total. I use Monte Carlo cross-validation to combat this. A training dataset is randomly sampled from the whole set, and then a separate seismic event is classified as an earthquake or explosion using the partition PaLD assigns to that test point. This is repeated 1000 times, and various machine learning metrics can be determined based on the classifications.  
  
  
# Results:  
  Taking the training samples to be size 30 (15 earthquakes and 15 explosions), the resulting confusion matrix is [[513, 75], [3, 409]]. In words, of the 513 cross-validation samples where the target was an earthquake, only 13 were incorrectly classified as explosions. Similarly, of the 487 samples where the target was an explosion, 79 were classified as earthquakes.








