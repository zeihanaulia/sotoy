
## Pendahuluan

Diskusi ini bermula dari pertanyaan tentang sistem XML tags yang digunakan oleh Dyad untuk structured output dalam AI chatbots. Awalnya terlihat seperti pendekatan yang "unik" atau "tidak mengikuti standar industri", namun penelitian mendalam mengungkap landscape yang jauh lebih kompleks.

## Temuan Utama: Tiga Pendekatan Utama

### 1. Anthropic/Claude Ecosystem: XML Tags Dominan

**Sumber Resmi:**
- [Anthropic Claude Documentation: Use XML Tags](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
- [AWS Blog: Claude 3 Prompt Engineering](https://aws.amazon.com/blogs/machine-learning/prompt-engineering-techniques-and-best-practices-learn-by-doing-with-anthropics-claude-3-on-amazon-bedrock/)

**Mengapa XML?**
> "Claude has been fine-tuned to pay special attention to XML tags. You can take advantage of this characteristic to clearly separate sections of your prompt."

**Best Practices Claude:**
- `<thinking>` untuk chain-of-thought reasoning
- `<answer>` untuk final responses
- `<context>` untuk background data
- `<instructions>` untuk task descriptions

### 2. OpenAI Ecosystem: JSON Schema + XML Formatting

**Sumber Resmi:**
- [OpenAI Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
- [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering)

**Pendekatan Hybrid:**
- **JSON Schema** untuk tool calling dan structured outputs
- **XML tags** sebagai supplementary formatting technique
- **Markdown** untuk general formatting

### 3. Vercel AI SDK: JSON Schema Fokus

**Sumber Resmi:**
- [Vercel AI SDK Documentation](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling)
- [Vercel AI Zod Integration](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-schemas-with-zod)

**Pendekatan:**
- Zod schemas untuk type-safe AI responses
- JSON Schema untuk tool validation
- Minimal XML usage

## Analisis Tools Coding Agent

### Dyad: XML Tags untuk Tool Calling

**Implementasi:**
```xml
<dyad-write file="src/Button.tsx">
  // React component code
</dyad-write>

<dyad-execute command="npm install react-router-dom" />
```

**Alasan Memilih XML:**
- **Streaming compatibility**: Incremental parsing selama AI response
- **Real-time UI feedback**: Complex operations dengan multiple steps
- **Claude-based**: Mengikuti Anthropic's best practices

### Bolt.diy: XML Tags untuk Development Workflow

**Implementasi:**
```xml
<boltArtifact id="create-app" title="Create React App">
  <boltAction type="shell">npm create vite@latest my-app</boltAction>
  <boltAction type="file" filePath="package.json">...</boltAction>
</boltArtifact>
```

**Temuan:** Bolt.diy juga menggunakan XML tags yang sama seperti Dyad, menunjukkan pola yang lebih luas dalam AI coding tools.

### AIML: Historical Precedent untuk XML dalam AI

**Sumber:** [Wikipedia: Artificial Intelligence Markup Language](https://en.wikipedia.org/wiki/Artificial_Intelligence_Markup_Language)

**Fakta Penting:**
- Dikembangkan oleh Dr. Richard Wallace (1995-2002)
- XML dialect khusus untuk chatbot
- A.L.I.C.E. memenangkan Loebner Prize 3x menggunakan AIML
- Masih aktif di Pandorabots dengan 200,000+ bots

## Perbandingan XML vs JSON Approaches

| Aspek | XML Approach (Claude/Dyad) | JSON Schema (OpenAI/Vercel) |
|-------|---------------------------|-----------------------------|
| **Parsing** | Incremental/streaming-friendly | Requires complete structures |
| **Complexity** | Supports nested hierarchies | Type-safe validation |
| **Tool Calling** | Custom XML tags | Standardized schemas |
| **Ecosystem** | Anthropic-focused tools | Industry-wide adoption |
| **Real-time UI** | Excellent for live updates | Less suitable for streaming |
| **Validation** | Manual parsing | Built-in schema validation |

## Mengapa XML untuk Coding Tools?

### 1. Streaming AI Responses
```xml
<dyad-write file="Button.tsx">
  <button>Click me</button>  <!-- Partial content -->
</dyad-write>
<!-- Can be parsed incrementally -->
```

vs JSON:
```json
{
  "tool": "write_file",
  "file": "Button.tsx",
  "content": "<button>Click me</button>"  // Must be complete
}
```

### 2. Complex Multi-step Operations
XML memungkinkan nesting dan hierarchical structures untuk operations yang kompleks:

```xml
<dyad-execute command="npm install">
  <dependency>react-router-dom</dependency>
  <post-install>
    <dyad-write file="App.tsx">import Router...</dyad-write>
  </post-install>
</dyad-execute>
```

### 3. Real-time UI Feedback
- XML tags dapat diparse secara bertahap
- UI dapat update secara real-time saat AI men-stream response
- Cocok untuk interactive development environments

## Kesimpulan: Landscape yang Kompleks

### Tidak Ada "Standar Tunggal"

**Sebelumnya:** "Mengapa Dyad menggunakan XML? Bukankah JSON lebih standard?"

**Sekarang:** Ternyata ada **tiga ecosystem berbeda** dengan pendekatan masing-masing:

1. **Anthropic/Claude**: XML tags sebagai first-class citizen
2. **OpenAI**: JSON Schema untuk tool calling, XML sebagai formatting aid
3. **Vercel**: JSON Schema dengan Zod untuk type safety

### Dyad's Choice: Strategically Sound

Dyad's XML approach bukan "unik" atau "tidak mengikuti standar" - tapi **mengikuti best practices dari Anthropic** untuk Claude-based applications. Pilihan ini optimal untuk:

- Streaming AI responses
- Real-time development feedback
- Complex multi-step operations
- Interactive coding environments

## Simulasi Lengkap: Dari User Request sampai Code Generation

### Scenario: User Minta "Buat web todo app dengan React"

### Step 1: User Input & Initial Processing
```
User: "Buat web todo app dengan React yang bisa add, edit, delete todo"
```

**Dyad's System Prompt** (berdasarkan Claude best practices):
```xml
<role> You are Dyad, an AI editor that creates and modifies web applications. You assist users by chatting with them and making changes to their code in real-time. You understand that users can see a live preview of their application in an iframe on the right side of the screen while you make code changes.
You make efficient and effective changes to codebases while following best practices for maintainability and readability. You take pride in keeping things simple and elegant. You are friendly and helpful, always aiming to provide clear explanations. </role>

# App Preview / Commands

Do *not* tell the user to run shell commands. Instead, they can do one of the following commands in the UI:

- **Rebuild**: This will rebuild the app from scratch. First it deletes the node_modules folder and then it re-installs the npm packages and then starts the app server.
- **Restart**: This will restart the app server.
- **Refresh**: This will refresh the app preview page.

You can suggest one of these commands by using the <dyad-command> tag like this:
<dyad-command type="rebuild"></dyad-command>
<dyad-command type="restart"></dyad-command>
<dyad-command type="refresh"></dyad-command>

If you output one of these commands, tell the user to look for the action button above the chat input.

# Guidelines

Always reply to the user in the same language they are using.

- Use <dyad-chat-summary> for setting the chat summary (put this at the end). The chat summary should be less than a sentence, but more than a few words. YOU SHOULD ALWAYS INCLUDE EXACTLY ONE CHAT TITLE
- Before proceeding with any code edits, check whether the user's request has already been implemented. If the requested change has already been made in the codebase, point this out to the user, e.g., "This feature is already implemented as described."
- Only edit files that are related to the user's request and leave all other files alone.

If new code needs to be written (i.e., the requested feature does not exist), you MUST:

- Briefly explain the needed changes in a few short sentences, without being too technical.
- Use <dyad-write> for creating or updating files. Try to create small, focused files that will be easy to maintain. Use only one <dyad-write> block per file. Do not forget to close the dyad-write tag after writing the file. If you do NOT need to change a file, then do not use the <dyad-write> tag.
- Use <dyad-rename> for renaming files.
- Use <dyad-delete> for removing files.
- Use <dyad-add-dependency> for installing packages.
  - If the user asks for multiple packages, use <dyad-add-dependency packages="package1 package2 package3"></dyad-add-dependency>
  - MAKE SURE YOU USE SPACES BETWEEN PACKAGES AND NOT COMMAS.
- After all of the code changes, provide a VERY CONCISE, non-technical summary of the changes made in one sentence, nothing more. This summary should be easy for non-technical users to understand. If an action, like setting a env variable is required by user, make sure to include it in the summary.

Before sending your final answer, review every import statement you output and do the following:

First-party imports (modules that live in this project)
- Only import files/modules that have already been described to you.
- If you need a project file that does not yet exist, create it immediately with <dyad-write> before finishing your response.

Third-party imports (anything that would come from npm)
- If the package is not listed in package.json, install it with <dyad-add-dependency>.

Do not leave any import unresolved.

# Tech Stack
- You are building a React application.
- Use TypeScript.
- Use React Router. KEEP the routes in src/App.tsx
- Always put source code in the src folder.
- Put pages into src/pages/
- Put components into src/components/
- The main page (default page) is src/pages/Index.tsx
- UPDATE the main page to include the new components. OTHERWISE, the user can NOT see any components!
- ALWAYS try to use the shadcn/ui library.
- Tailwind CSS: always use Tailwind CSS for styling components. Utilize Tailwind classes extensively for layout, spacing, colors, and other design aspects.

Available packages and libraries:
- The lucide-react package is installed for icons.
- You ALREADY have ALL the shadcn/ui components and their dependencies installed. So you don't need to install them again.
- You have ALL the necessary Radix UI components installed.
- Use prebuilt components from the shadcn/ui library after importing them. Note that these files shouldn't be edited, so make new components if you need to change them.
```

### Step 2: AI Processing & Planning
AI (Claude) memproses request dan membuat rencana:

```xml
<thinking>
  User wants a React todo app with CRUD operations. I need to:
  1. Create React app structure
  2. Implement TodoList and TodoItem components  
  3. Add state management for todos
  4. Implement add, edit, delete functions
  5. Style the components
  
  This requires multiple files and npm packages.
</thinking>
```

### Step 3: XML Tag Generation (Streaming Response)
AI mulai generate XML tags secara bertahap:

```xml
<dyadArtifact id="react-todo-app" title="React Todo Application">

  <dyadAction type="shell">
    npm create vite@latest todo-app -- --template react-ts
  </dyadAction>
  
  <dyadAction type="file" filePath="src/App.tsx">
    import React, { useState } from 'react';
    import TodoList from './components/TodoList';
    import AddTodo from './components/AddTodo';
    import './App.css';

    function App() {
      const [todos, setTodos] = useState([]);
      
      const addTodo = (text) => {
        setTodos([...todos, { id: Date.now(), text, completed: false }]);
      };
      
      const toggleTodo = (id) => {
        setTodos(todos.map(todo => 
          todo.id === id ? { ...todo, completed: !todo.completed } : todo
        ));
      };
      
      const deleteTodo = (id) => {
        setTodos(todos.filter(todo => todo.id !== id));
      };
      
      return (
        <div className="App">
          <h1>Todo App</h1>
          <AddTodo onAdd={addTodo} />
          <TodoList todos={todos} onToggle={toggleTodo} onDelete={deleteTodo} />
        </div>
      );
    }

    export default App;
  </dyadAction>
  
  <dyadAction type="file" filePath="src/components/TodoList.tsx">
    import React from 'react';
    import TodoItem from './TodoItem';

    const TodoList = ({ todos, onToggle, onDelete }) => {
      return (
        <ul className="todo-list">
          {todos.map(todo => (
            <TodoItem 
              key={todo.id} 
              todo={todo} 
              onToggle={onToggle} 
              onDelete={onDelete} 
            />
          ))}
        </ul>
      );
    };

    export default TodoList;
  </dyadAction>
  
  <dyadAction type="file" filePath="src/components/TodoItem.tsx">
    import React, { useState } from 'react';

    const TodoItem = ({ todo, onToggle, onDelete }) => {
      const [isEditing, setIsEditing] = useState(false);
      const [editText, setEditText] = useState(todo.text);

      const handleEdit = () => {
        if (isEditing) {
          // Call edit function (would need to be passed down)
          setIsEditing(false);
        } else {
          setIsEditing(true);
        }
      };

      return (
        <li className={`todo-item ${todo.completed ? 'completed' : ''}`}>
          {isEditing ? (
            <input 
              type="text" 
              value={editText} 
              onChange={(e) => setEditText(e.target.value)}
              onBlur={handleEdit}
              onKeyPress={(e) => e.key === 'Enter' && handleEdit()}
            />
          ) : (
            <span onClick={() => onToggle(todo.id)}>{todo.text}</span>
          )}
          
          <button onClick={handleEdit}>{isEditing ? 'Save' : 'Edit'}</button>
          <button onClick={() => onDelete(todo.id)}>Delete</button>
        </li>
      );
    };

    export default TodoItem;
  </dyadAction>
  
  <dyadAction type="file" filePath="src/components/AddTodo.tsx">
    import React, { useState } from 'react';

    const AddTodo = ({ onAdd }) => {
      const [text, setText] = useState('');

      const handleSubmit = (e) => {
        e.preventDefault();
        if (text.trim()) {
          onAdd(text);
          setText('');
        }
      };

      return (
        <form onSubmit={handleSubmit} className="add-todo">
          <input 
            type="text" 
            value={text} 
            onChange={(e) => setText(e.target.value)}
            placeholder="Add a new todo..."
          />
          <button type="submit">Add</button>
        </form>
      );
    };

    export default AddTodo;
  </dyadAction>
  
  <dyadAction type="file" filePath="src/App.css">
    .App {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .todo-list {
      list-style: none;
      padding: 0;
    }

    .todo-item {
      display: flex;
      align-items: center;
      padding: 10px;
      margin: 5px 0;
      border: 1px solid #ddd;
      border-radius: 4px;
      background: #f9f9f9;
    }

    .todo-item.completed span {
      text-decoration: line-through;
      color: #888;
    }

    .todo-item span {
      flex: 1;
      cursor: pointer;
    }

    .todo-item button {
      margin-left: 10px;
      padding: 5px 10px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }

    .todo-item button:first-of-type {
      background: #007bff;
      color: white;
    }

    .todo-item button:last-of-type {
      background: #dc3545;
      color: white;
    }

    .add-todo {
      display: flex;
      margin-bottom: 20px;
    }

    .add-todo input {
      flex: 1;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px 0 0 4px;
    }

    .add-todo button {
      padding: 10px 20px;
      background: #28a745;
      color: white;
      border: none;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }
  </dyadAction>
  
  <dyadAction type="start">
    npm run dev
  </dyadAction>
  
</dyadArtifact>
<dyad-chat-summary>Creating a React todo app with add, edit, and delete functionality</dyad-chat-summary>
```

**Simulasi Response Lengkap dari AI:**

```
OK, saya akan membuat aplikasi todo React dengan fitur add, edit, dan delete. Saya akan menggunakan React dengan TypeScript dan Tailwind CSS untuk styling.

<dyadArtifact id="react-todo-app" title="React Todo Application">

  <dyadAction type="shell">
    npm create vite@latest todo-app -- --template react-ts
  </dyadAction>
  
  <dyadAction type="file" filePath="src/App.tsx">
    import React, { useState } from 'react';
    import TodoList from './components/TodoList';
    import AddTodo from './components/AddTodo';
    import './App.css';

    function App() {
      const [todos, setTodos] = useState([]);
      
      const addTodo = (text) => {
        setTodos([...todos, { id: Date.now(), text, completed: false }]);
      };
      
      const toggleTodo = (id) => {
        setTodos(todos.map(todo => 
          todo.id === id ? { ...todo, completed: !todo.completed } : todo
        ));
      };
      
      const deleteTodo = (id) => {
        setTodos(todos.filter(todo => todo.id !== id));
      };
      
      return (
        <div className="App">
          <h1>Todo App</h1>
          <AddTodo onAdd={addTodo} />
          <TodoList todos={todos} onToggle={toggleTodo} onDelete={deleteTodo} />
        </div>
      );
    }

    export default App;
  </dyadAction>
  
  [konten file lainnya...]
  
  <dyadAction type="start">
    npm run dev
  </dyadAction>
  
</dyadArtifact>
<dyad-chat-summary>Creating a React todo app with add, edit, and delete functionality</dyad-chat-summary>
```

**Bagaimana System Prompt Menghasilkan Response:**

1. **Role Definition**: "You are Dyad, an AI editor..." → AI memahami konteks sebagai code editor
2. **Guidelines**: "Use <dyad-write> for creating files..." → AI menggunakan XML tags yang tepat
3. **Tech Stack**: "You are building a React application. Use TypeScript..." → AI menggunakan React + TS
4. **Available Libraries**: "ALWAYS try to use the shadcn/ui library..." → AI menggunakan Tailwind CSS
5. **Response Format**: "After all code changes, provide summary..." → AI menambahkan `<dyad-chat-summary>`

**Streaming Nature**: Response di-generate secara bertahap, memungkinkan parsing real-time oleh DyadMarkdownParser.

### Step 4: Real-time Parsing & Execution
**DyadMarkdownParser** memproses XML tags secara streaming:

```typescript
// Pseudo-code of parsing process
const parseStreamingXML = (chunk: string) => {
  // Parse partial XML incrementally
  if (chunk.includes('<dyadAction type="shell">')) {
    // Execute shell command immediately
    executeShellCommand(extractCommand(chunk));
  }
  
  if (chunk.includes('<dyadAction type="file"')) {
    // Start collecting file content
    startFileCollection(extractFilePath(chunk));
  }
  
  // Update UI with partial results
  updateUIWithPartialContent();
};
```

### Step 5: UI Feedback & State Management
**Real-time UI updates** saat AI streaming:

```typescript
// Jotai atoms for state management
const executionState = atom({
  status: 'pending', // 'finished' | 'pending' | 'aborted'
  currentAction: null,
  completedActions: [],
  errors: []
});

// UI components update based on execution state
const ActionStatus = ({ action }) => {
  const [state] = useAtom(executionState);
  
  return (
    <div className={`action ${state.status}`}>
      {state.status === 'pending' && <Spinner />}
      {state.status === 'finished' && <CheckIcon />}
      <span>{action.description}</span>
    </div>
  );
};
```

### Step 6: Final Result
**User melihat aplikasi jadi** dengan:
- ✅ React app ter-create
- ✅ Components ter-generate  
- ✅ State management implemented
- ✅ Styling applied
- ✅ Dev server running

**Proses lengkap** dari text input → AI processing → XML streaming → real-time parsing → code execution → UI updates.

## Implikasi untuk Future AI Tools

Coding agent tools kemungkinan akan berkembang dalam **tiga jalur paralel**:

1. **Claude-based tools**: XML tags (Dyad, Bolt.diy)
2. **OpenAI-based tools**: JSON Schema
3. **Multi-provider tools**: Hybrid approaches

## Referensi Lengkap

### Dokumentasi Resmi
- [Anthropic: XML Tags Guide](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
- [AWS: Claude Prompt Engineering](https://aws.amazon.com/blogs/machine-learning/prompt-engineering-techniques-and-best-practices-learn-by-doing-with-anthropics-claude-3-on-amazon-bedrock/)
- [OpenAI: Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
- [Vercel AI: Tool Calling](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling)

### Tools yang Dianalisis
- [Dyad Repository](https://github.com/dyad-sh/dyad)
- [Bolt.diy Repository](https://github.com/stackblitz-labs/bolt.diy)
- [AIML Wikipedia](https://en.wikipedia.org/wiki/Artificial_Intelligence_Markup_Language)

---

*Diskusi ini menunjukkan bahwa "standar industri" dalam AI prompt engineering ternyata lebih kompleks daripada yang terlihat. Setiap provider memiliki pendekatan optimal untuk use case mereka, dan XML tags ternyata direkomendasikan oleh Anthropic untuk Claude-based applications.*