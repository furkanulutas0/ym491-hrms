import React, { useState, useEffect } from 'react';
import { JobAssistResponse } from '@/features/ai/api/ai-api';
import { Button } from '@/components/ui/button';

interface AIReviewModalProps {
  currentValues: any;
  suggestedValues: JobAssistResponse;
  onApply: (data: any) => void;
  onClose: () => void;
}

export default function AIReviewModal({ currentValues, suggestedValues, onApply, onClose }: AIReviewModalProps) {
  // State to track which suggestions are selected (true = use suggestion, false = keep current)
  // For lists, we track individual items if possible, but the backend returns a full list replacement.
  // To keep it aligned with the template "checkboxes", we will assume the suggestion list is what we are "selecting from".
  // So for a list field, we will have a sub-state of selected indices.
  
  const [selectedFields, setSelectedFields] = useState<Record<string, boolean>>({
    title: true,
    department: true,
    description: true,
    // For lists, we will track them separately or just binary for now? 
    // The template has checkboxes PER ITEM.
    // Let's create a more complex state.
  });

  const [selectedListItems, setSelectedListItems] = useState<Record<string, boolean[]>>({});

  useEffect(() => {
    // Initialize selections
    // Default: Select all suggestions
    const initialListSelections: Record<string, boolean[]> = {};
    
    if (suggestedValues.responsibilities) {
      initialListSelections.responsibilities = new Array(suggestedValues.responsibilities.length).fill(true);
    }
    if (suggestedValues.requirements) {
      initialListSelections.requirements = new Array(suggestedValues.requirements.length).fill(true);
    }
    if (suggestedValues.benefits) {
      initialListSelections.benefits = new Array(suggestedValues.benefits.length).fill(true);
    }
    
    setSelectedListItems(initialListSelections);
    
    // For simple fields, default to true if suggestion is different
    const initialFieldSelections: Record<string, boolean> = {};
    ['title', 'department', 'description'].forEach(field => {
      if (suggestedValues[field] && suggestedValues[field] !== currentValues[field]) {
        initialFieldSelections[field] = true;
      } else {
        initialFieldSelections[field] = false;
      }
    });
    setSelectedFields(initialFieldSelections);
  }, [suggestedValues, currentValues]);

  const handleApply = () => {
    const finalData: any = {};

    // Apply simple fields
    ['title', 'department', 'description'].forEach(field => {
      if (selectedFields[field]) {
        finalData[field] = suggestedValues[field];
      }
    });

    // Apply list fields
    ['responsibilities', 'requirements', 'benefits'].forEach(field => {
      const suggestions = suggestedValues[field as keyof JobAssistResponse] as string[];
      if (!suggestions) return;

      const selectedIndices = selectedListItems[field];
      if (selectedIndices) {
        // We only take the selected suggestions.
        // What about the *current* items?
        // The typical "AI Assist" flow usually REPLACES or MERGES.
        // If I uncheck a suggestion, does it mean "Don't add this"? Yes.
        // Does it mean "Keep the old one"? 
        // The prompt says "Improve and complete". The AI response is a full replacement.
        // So the user is building the *new* list from the *suggested* list.
        // If they want to keep old items that aren't in suggestion, they can't with this UI easily unless we merge lists.
        // For simplicity and matching the "Review" concept, we will construct the list from the CHECKED suggestions.
        // If the user wants to mix and match, they might need a more complex UI, but "Accepting AI" usually implies trusting the generated content.
        
        finalData[field] = suggestions.filter((_, i) => selectedIndices[i]);
      }
    });

    onApply(finalData);
    onClose();
  };

  const toggleListItem = (field: string, index: number) => {
    setSelectedListItems(prev => ({
      ...prev,
      [field]: prev[field].map((val, i) => i === index ? !val : val)
    }));
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">
      <div className="bg-white dark:bg-[#1e2532] border border-slate-200 dark:border-slate-700 w-full max-w-2xl rounded-2xl shadow-2xl flex flex-col max-h-[90vh] animate-in zoom-in-95 duration-300 overflow-hidden">
        
        {/* Header */}
        <div className="flex items-start justify-between p-6 border-b border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-[#1e2532] relative overflow-hidden shrink-0">
          <div className="absolute -top-10 -left-10 w-32 h-32 bg-primary/20 rounded-full blur-3xl pointer-events-none"></div>
          <div className="flex gap-4 relative z-10">
            <div className="size-12 rounded-xl bg-gradient-to-br from-primary to-purple-600 flex items-center justify-center shadow-lg shadow-primary/20 shrink-0">
              <span className="material-symbols-outlined text-white text-[28px]">auto_awesome</span>
            </div>
            <div>
              <h3 className="text-xl font-bold text-slate-900 dark:text-white mb-1">AI-Generated Job Details</h3>
              <p className="text-slate-500 dark:text-slate-400 text-sm">
                Suggestions based on your input. Uncheck items to discard them.
              </p>
            </div>
          </div>
          <button 
            onClick={onClose}
            className="text-slate-400 hover:text-slate-600 dark:text-slate-500 dark:hover:text-slate-300 transition-colors rounded-full p-1 hover:bg-slate-100 dark:hover:bg-white/5"
          >
            <span className="material-symbols-outlined">close</span>
          </button>
        </div>

        {/* Body */}
        <div className="overflow-y-auto p-6 space-y-8 bg-white dark:bg-[#151b26] custom-scrollbar">
          
          {/* Job Details Section (Title, etc) */}
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <h4 className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Job Details</h4>
            </div>
            <div className="space-y-3">
              {['title', 'department', 'description'].map(field => {
                if (!suggestedValues[field]) return null;
                const isSelected = selectedFields[field];
                return (
                  <label key={field} className="group flex items-start gap-3 p-3 rounded-lg bg-slate-50 dark:bg-[#1e2532] border border-slate-200 dark:border-slate-700 hover:border-primary/50 cursor-pointer transition-all">
                    <input 
                      type="checkbox" 
                      checked={isSelected}
                      onChange={(e) => setSelectedFields(prev => ({ ...prev, [field]: e.target.checked }))}
                      className="mt-1 rounded border-slate-300 dark:border-slate-600 bg-white dark:bg-[#111621] text-primary focus:ring-primary focus:ring-offset-0 size-4" 
                    />
                    <div className="flex-1">
                      <span className="text-xs font-bold text-slate-400 dark:text-slate-500 uppercase mb-1 block">{field}</span>
                      <p className="text-sm text-slate-700 dark:text-slate-200 leading-relaxed group-hover:text-slate-900 dark:group-hover:text-white">
                        {suggestedValues[field]}
                      </p>
                    </div>
                  </label>
                );
              })}
            </div>
          </div>

          {/* List Sections */}
          {[
            { key: 'responsibilities', label: 'Key Responsibilities' },
            { key: 'requirements', label: 'Requirements' },
            { key: 'benefits', label: 'Suggested Benefits' }
          ].map(({ key, label }) => {
            const items = suggestedValues[key as keyof JobAssistResponse] as string[];
            if (!items || items.length === 0) return null;

            return (
              <div key={key} className="space-y-4">
                <div className="flex items-center justify-between">
                  <h4 className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">{label}</h4>
                  {/* Optional 'High Confidence' badge could go here if we had data for it */}
                </div>
                <div className="space-y-2">
                  {items.map((item, index) => {
                    const isChecked = selectedListItems[key]?.[index] ?? true;
                    return (
                      <label key={index} className="group flex items-start gap-3 p-3 rounded-lg bg-slate-50 dark:bg-[#1e2532] border border-slate-200 dark:border-slate-700 hover:border-primary/50 cursor-pointer transition-all">
                        <input 
                          type="checkbox" 
                          checked={isChecked}
                          onChange={() => toggleListItem(key, index)}
                          className="mt-1 rounded border-slate-300 dark:border-slate-600 bg-white dark:bg-[#111621] text-primary focus:ring-primary focus:ring-offset-0 size-4" 
                        />
                        <span className={`text-sm leading-relaxed transition-colors ${isChecked ? 'text-slate-700 dark:text-slate-200 group-hover:text-slate-900 dark:group-hover:text-white' : 'text-slate-400 dark:text-slate-500 line-through decoration-slate-400'}`}>
                          {item}
                        </span>
                      </label>
                    );
                  })}
                </div>
              </div>
            );
          })}

        </div>

        {/* Footer */}
        <div className="p-6 border-t border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-[#1e2532] rounded-b-2xl flex flex-col sm:flex-row items-center justify-between gap-4 shrink-0">
          <button 
            onClick={onClose}
            className="text-sm font-medium text-slate-500 dark:text-slate-400 hover:text-red-500 dark:hover:text-red-400 transition-colors px-2 py-1"
          >
            Discard Suggestions
          </button>
          <div className="flex items-center gap-3 w-full sm:w-auto">
            {/* Review & Edit could be just closing and letting them edit the form, or keeping this modal open. 
                For now, 'Discard' closes. 'Accept' applies and closes. 
                Maybe 'Review & Edit' isn't needed if they can just edit checkboxes. 
                I'll omit it to simplify or treat it as 'Close without applying' which is Discard.
            */}
            <button 
              onClick={handleApply}
              className="flex-1 sm:flex-none px-5 py-2.5 rounded-lg bg-primary hover:bg-primary/90 text-white font-medium text-sm shadow-lg shadow-primary/25 transition-all flex items-center justify-center gap-2 focus:ring-2 focus:ring-offset-2 focus:ring-offset-[#1e2532] focus:ring-primary"
            >
              <span>Accept Selected</span>
              <span className="material-symbols-outlined text-[18px]">check</span>
            </button>
          </div>
        </div>

      </div>
    </div>
  );
}

