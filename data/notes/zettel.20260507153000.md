
Claim: Karpathy’s LLM Wiki is a knowledge compilation pattern where LLMs recompile raw documents into an evolving markdown wiki, creating a persistent layer that supports understanding, not just retrieval.

Evidence:
- Karpathy published a GitHub Gist `llm-wiki` in early April 2026 as a blueprint for building LLM-powered knowledge bases.
- The pattern is described as: raw docs → LLM compile → structured markdown wiki → query/update → wiki matures.
- This differs from classic RAG: RAG retrieves chunks at query time, while LLM Wiki creates a persistent, human-readable knowledge layer that can be refined incrementally.
- Early implementations and community projects such as Pratiyush/llm-wiki, lucasastorian/llmwiki, and OpenKB explicitly cite Karpathy’s gist as the pattern source.
- The approach is understood as a way to make large unstructured documents more interpretable by reframing them into wiki pages, outlines, glossaries, and Q&A, rather than just searching raw text.

Why it matters:
- It positions the LLM as a compiler of meaning, not merely a search engine.
- It supports the idea that LLM tools can preprocess and structure knowledge for human understanding while leaving the ultimate understanding with the reader.
- It offers a concrete architecture for applying LLMs beyond code generation to personal knowledge management and research workflows.

Sources:
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://denser.ai/blog/llm-wiki-karpathy-knowledge-base/
- https://academy.dair.ai/blog/llm-knowledge-bases-karpathy
- https://www.capitalnewstoday.com/article/karpathy-shares-llm-knowledge-base-architecture-that-bypasses-rag-with-an-evolving-markdown-library--9i1xh8
- https://anthemcreation.com/en/artificial-intelligence/karpathy-llm-wiki-claude-obsidian/
- https://github.com/Pratiyush/llm-wiki
- https://github.com/topics/llm-wiki
- https://www.reddit.com/r/ClaudeCode/comments/1sm374u/turned_andrej_karpathys_llm_wiki_gist_into_a/

Related notes:
- [[zettel.literature.karpathy-from-vibe-coding-to-agentic-engineering]]
