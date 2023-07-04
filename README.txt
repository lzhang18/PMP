This is source code for the SDM23 paper: PMP: Privacy-Aware Matrix Profile against Sensitive Pattern Inference for Time Series. 

\href{Paper link}{https://epubs.siam.org/doi/abs/10.1137/1.9781611977653.ch100}

Usage: 

To run the demo, please run the attack_demo. We have two variations of the protection code:

run_protect.m: will run the protection algorithm with precompute distances in the time series.

run_protect_v2.m: will run the protection algorithm in the time series while computing the distance.

info_attack.m: The entropy-based attack

loc_attack.m: The location-based attack

MASS_V3.m is adopted from https://www.cs.unm.edu/~mueen/FastestSimilaritySearch.html

stompSelf.m is adopted from Zhu and Yeh in Matrix Profile II.

If you find this repository useful for your research, please consider citing the following papers:

@inproceedings{zhang2023pmp,
  title={PMP: Privacy-Aware Matrix Profile against Sensitive Pattern Inference for Time Series},
  author={Zhang, Li and Ding, Jiahao and Gao, Yifeng and Lin, Jessica},
  booktitle={Proceedings of the 2023 SIAM International Conference on Data Mining (SDM)},
  pages={891--899},
  year={2023},
  organization={SIAM}
}

