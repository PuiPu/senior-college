

# recursion tree trace
```
PlaceQueens(Q, 1)
│   (放第1列)
├── Q[1]=1 → PlaceQueens(Q, 2)
│            │   (放第2列)
│            ├── Q[2]=1 ✗ conflict
│            ├── Q[2]=2 ✗ conflict
│            ├── Q[2]=3 → PlaceQueens(Q, 3)
│            │            │   (放第3列)
│            │            ├── Q[3]=1 ✗ conflict
│            │            ├── Q[3]=2 ✗ conflict
│            │            ├── Q[3]=3 ✗ conflict
│            │            ├── Q[3]=4 → PlaceQueens(Q, 4)
│            │            │            │   (放第4列)
│            │            │            ├── Q[4]=1 ✗
│            │            │            ├── Q[4]=2 ✓ → PlaceQueens(Q, 5)
│            │            │            │                 (r = n + 1)
│            │            │            │                 ✅ 印出一組解
│            │            │            ├── Q[4]=3 ✗
│            │            │            └── Q[4]=4 ✗
│            │            └── (回溯)
│            └── Q[2]=4 ✗
│
├── Q[1]=2 → PlaceQueens(Q, 2)
│            ├── Q[2]=1 ✓ → PlaceQueens(Q, 3)
│            │                ...
│            └── 其他分支 ...
│
├── Q[1]=3 → PlaceQueens(Q, 2)
│            ...
│
└── Q[1]=4 → PlaceQueens(Q, 2)
             ...

```
