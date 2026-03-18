#!/bin/bash

# انتظر حتى يشتغل AnythingLLM
echo "⏳ Waiting for AnythingLLM to start..."
sleep 30

# رابط AnythingLLM
ANYTHINGLLM_URL="http://localhost:3001"
API_KEY="${ANYTHINGLLM_API_KEY}"
WORKSPACE_SLUG="mstchar-qanwny"
DOCS_DIR="/app/documents"

echo "📁 Uploading documents to AnythingLLM..."

# ارفع كل PDF
for pdf in "$DOCS_DIR"/*.pdf; do
  if [ -f "$pdf" ]; then
    filename=$(basename "$pdf")
    echo "📄 Uploading: $filename"
    
    curl -s -X POST "$ANYTHINGLLM_URL/api/v1/document/upload" \
      -H "Authorization: Bearer $API_KEY" \
      -F "file=@$pdf" \
      > /dev/null
    
    echo "✅ Done: $filename"
  fi
done

echo "🎉 All documents uploaded!"
