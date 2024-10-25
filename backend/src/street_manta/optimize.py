from typing import List

import networkx as nx
from networkx import DiGraph

def optimize(graph: DiGraph)-> List[List[str]]:
    results = []
    g_undirected = graph.to_undirected(reciprocal=True)
    match = nx.max_weight_matching(g_undirected)
    res_k2 = []
    for u,v in match:
        res_k2.extend([u,v])
        results.append([u,v])
    res_k2 = set(res_k2)

    edge_list = []
    for u,v in list(graph.edges):
        if u not in res_k2 and v not in res_k2:
            edge_list.append((u,v, graph.get_edge_data(u,v)))
    g2 = nx.DiGraph()
    g2.add_edges_from(edge_list)
    for i in range(3, 5):
        while True:
            cycles = list(nx.simple_cycles(g2, length_bound=i))
            if len(cycles) == 0:
                break
            visited_nodes = set()
            for c in sorted(cycles, key=lambda c: min([g2[c[j]][c[(j+1) % len(c)]]['weight'] for j in range(len(c))]), reverse=True):#sorted(cycles, key=len, reverse=True):
                if not any([v in visited_nodes for v in c]):
                    visited_nodes.update(c)
                    results.append(c)
            g2.remove_nodes_from(visited_nodes)
            break
    return results