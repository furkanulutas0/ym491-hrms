"use client";

import { useForm, useFieldArray } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useCreateJob, useUpdateJob } from "@/features/recruitment/hooks/use-jobs";
import { useGenerateContent, useAssistJobPosting } from "@/features/ai/hooks/use-ai";
import { JobPosting } from "@/features/recruitment/types";
import { JobAssistResponse } from "@/features/ai/api/ai-api";

const jobPostingSchema = z.object({
  title: z.string().min(1, "Job title is required"),
  department: z.string().optional(),
  location: z.string().optional(),
  work_type: z.string().optional(),
  status: z.enum(["Draft", "Active", "Closed", "Paused"]).default("Draft"),
  description: z.string().optional(),
  responsibilities: z.array(z.string().min(1, "Responsibility cannot be empty")),
  requirements: z.array(z.string().min(1, "Requirement cannot be empty")),
  benefits: z.array(z.string().min(1, "Benefit cannot be empty")),
  salary_range_min: z.string().transform((val) => (val ? parseInt(val) : null)).nullable().optional(),
  salary_range_max: z.string().transform((val) => (val ? parseInt(val) : null)).nullable().optional(),
  salary_currency: z.string().default("USD"),
  expiration_date: z.string().optional().nullable(),
});

type JobPostingFormValues = z.infer<typeof jobPostingSchema>;

interface JobPostingFormProps {
  initialData?: JobPosting;
  jobId?: number;
}

export default function JobPostingForm({ initialData, jobId }: JobPostingFormProps) {
  const router = useRouter();
  const createJobMutation = useCreateJob();
  const updateJobMutation = useUpdateJob();
  const generateContentMutation = useGenerateContent();
  const assistJobMutation = useAssistJobPosting();
  const [showAiSuggestions, setShowAiSuggestions] = useState(true);
  const [reviewData, setReviewData] = useState<JobAssistResponse | null>(null);

  const isEditing = !!initialData && !!jobId;

  const defaultValues: any = initialData ? {
    title: initialData.title || "",
    department: initialData.department || "",
    location: initialData.location || "",
    work_type: initialData.work_type || "Onsite",
    status: (initialData.status as any) || "Draft",
    description: initialData.description || "",
    responsibilities: initialData.responsibilities || [],
    requirements: initialData.requirements || [],
    benefits: initialData.benefits || [],
    salary_currency: initialData.salary_currency || "USD",
    salary_range_min: initialData.salary_range_min?.toString() || "",
    salary_range_max: initialData.salary_range_max?.toString() || "",
    expiration_date: initialData.expiration_date ? new Date(initialData.expiration_date).toISOString().split('T')[0] : "",
  } : {
    title: "",
    department: "",
    location: "",
    work_type: "Onsite",
    status: "Draft",
    description: "",
    responsibilities: [],
    requirements: [],
    benefits: [],
    salary_currency: "USD",
    salary_range_min: "",
    salary_range_max: "",
  };

  const {
    register,
    control,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm<JobPostingFormValues>({
    resolver: zodResolver(jobPostingSchema),
    defaultValues,
  });

  const { fields: responsibilitiesFields, append: appendResponsibility, remove: removeResponsibility } = useFieldArray({
    control,
    name: "responsibilities" as any,
  });

  const { fields: requirementsFields, append: appendRequirement, remove: removeRequirement } = useFieldArray({
    control,
    name: "requirements" as any,
  });

  const { fields: benefitsFields, append: appendBenefit, remove: removeBenefit } = useFieldArray({
    control,
    name: "benefits" as any,
  });

  const onSubmit = (data: JobPostingFormValues) => {
    // Transform empty strings to null for date
    const formattedData: any = {
      ...data,
      expiration_date: data.expiration_date || null,
    };
    
    if (isEditing && jobId) {
      updateJobMutation.mutate({ id: jobId, data: formattedData }, {
        onSuccess: () => {
          router.push("/dashboard/recruitment");
        },
      });
    } else {
      createJobMutation.mutate(formattedData, {
        onSuccess: () => {
          router.push("/dashboard/recruitment");
        },
      });
    }
  };

  const isPending = createJobMutation.isPending || updateJobMutation.isPending;

  const handleSmartEnhance = () => {
    const currentValues = watch();
    const requestData = {
      title: currentValues.title || "Untitled Position",
      department: currentValues.department,
      location: currentValues.location,
      work_type: currentValues.work_type,
      description: currentValues.description,
      responsibilities: currentValues.responsibilities,
      requirements: currentValues.requirements,
      benefits: currentValues.benefits
    };

    assistJobMutation.mutate(requestData, {
      onSuccess: (data) => {
        setReviewData(data);
        // Initialize all suggestions as checked by default
        setSelectedSuggestions({
          responsibilities: (data.responsibilities || []).map(() => true),
          requirements: (data.requirements || []).map(() => true),
          benefits: (data.benefits || []).map(() => true)
        });
      }
    });
  };

  const applySuggestion = (field: keyof JobAssistResponse, value: any) => {
    if (field === 'responsibilities' || field === 'requirements' || field === 'benefits') {
      setValue(field as any, value);
    } else {
      setValue(field as any, value);
    }
  };

  const [selectedSuggestions, setSelectedSuggestions] = useState<{
    responsibilities: boolean[];
    requirements: boolean[];
    benefits: boolean[];
  }>({
    responsibilities: [],
    requirements: [],
    benefits: []
  });

  const handleCheckboxChange = (section: 'responsibilities' | 'requirements' | 'benefits', index: number) => {
    setSelectedSuggestions(prev => ({
      ...prev,
      [section]: prev[section].map((val, i) => i === index ? !val : val)
    }));
  };

  const acceptSelectedSuggestions = () => {
    if (!reviewData) return;

    // Apply selected responsibilities
    const selectedResponsibilities = (reviewData.responsibilities || []).filter((_, i) => 
      selectedSuggestions.responsibilities[i]
    );
    if (selectedResponsibilities.length > 0) {
      const current = watch('responsibilities') || [];
      setValue('responsibilities', [...current, ...selectedResponsibilities]);
    }

    // Apply selected requirements
    const selectedRequirements = (reviewData.requirements || []).filter((_, i) => 
      selectedSuggestions.requirements[i]
    );
    if (selectedRequirements.length > 0) {
      const current = watch('requirements') || [];
      setValue('requirements', [...current, ...selectedRequirements]);
    }

    // Apply selected benefits
    const selectedBenefits = (reviewData.benefits || []).filter((_, i) => 
      selectedSuggestions.benefits[i]
    );
    if (selectedBenefits.length > 0) {
      const current = watch('benefits') || [];
      setValue('benefits', [...current, ...selectedBenefits]);
    }

    // Also update text fields if they were suggested and aren't empty
    if (reviewData.description && reviewData.description !== watch('description')) {
      setValue('description', reviewData.description);
    }
    if (reviewData.department && !watch('department')) {
      setValue('department', reviewData.department);
    }

    closeReview();
  };

  const acceptAllSuggestions = () => {
    if (!reviewData) return;
    
    // Apply all array suggestions (replacing current values)
    if (reviewData.responsibilities?.length) setValue('responsibilities', reviewData.responsibilities);
    if (reviewData.requirements?.length) setValue('requirements', reviewData.requirements);
    if (reviewData.benefits?.length) setValue('benefits', reviewData.benefits);
    
    // Apply text fields
    if (reviewData.description) setValue('description', reviewData.description);
    if (reviewData.department && !watch('department')) setValue('department', reviewData.department);
    
    closeReview();
  };

  const closeReview = () => {
    setReviewData(null);
    setSelectedSuggestions({
      responsibilities: [],
      requirements: [],
      benefits: []
    });
  };

  const handleGenerateDescription = () => {
    const title = watch("title");
    const department = watch("department");
    
    if (!title) {
      // Could show a toast here ideally
      alert("Please enter a job title first");
      return;
    }

    generateContentMutation.mutate({
      prompt: `Write a professional job description for a ${title} position${department ? ` in the ${department} department` : ''}. Include key responsibilities and requirements.`,
      task_type: "generic"
    }, {
      onSuccess: (response) => {
        setValue("description", response.content);
      }
    });
  };

  // Helper for dynamic list section
  const renderListSection = (
    title: string, 
    fields: any[], 
    append: (value: any) => void, 
    remove: (index: number) => void, 
    registerName: string,
    placeholder: string
  ) => (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <Label>{title}</Label>
        <button
          type="button"
          onClick={() => append(" ")} 
          className="text-primary text-sm font-medium hover:underline"
        >
          + Add Item
        </button>
      </div>
      <div className="space-y-3">
        {fields.map((field, index) => (
          <div key={field.id} className="flex gap-2">
            <Input
              {...register(`${registerName}.${index}` as any)}
              placeholder={placeholder}
              className="flex-1"
            />
            <button
              type="button"
              onClick={() => remove(index)}
              className="p-3 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors"
            >
              <span className="material-symbols-outlined">delete</span>
            </button>
          </div>
        ))}
        {fields.length === 0 && (
          <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark italic">
            No items added yet.
          </p>
        )}
      </div>
    </div>
  );

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-8 min-w-full mx-auto pb-12">
      <div className="bg-card-light dark:bg-card-dark p-6 rounded-xl border border-border-light dark:border-border-dark space-y-6">
        <h2 className="text-xl font-bold text-text-primary-light dark:text-text-primary-dark border-b border-border-light dark:border-border-dark pb-4">
          Basic Information
        </h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="space-y-2">
            <Label htmlFor="title">Job Title *</Label>
            <Input
              id="title"
              placeholder="e.g. Senior Software Engineer"
              {...register("title")}
            />
            {errors.title && <p className="text-red-500 text-sm">{errors.title.message}</p>}
          </div>

          <div className="space-y-2">
            <Label htmlFor="department">Department</Label>
            <Input
              id="department"
              placeholder="e.g. Engineering"
              {...register("department")}
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="location">Location</Label>
            <Input
              id="location"
              placeholder="e.g. New York, NY"
              {...register("location")}
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="work_type">Work Type</Label>
            <div className="relative">
              <select
                id="work_type"
                {...register("work_type")}
                className="flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-primary/50 border border-slate-300 dark:border-[#344465] bg-white dark:bg-[#1a2232] focus:border-primary dark:focus:border-primary h-14 p-[15px] text-base font-normal leading-normal appearance-none"
              >
                <option value="Onsite">Onsite</option>
                <option value="Hybrid">Hybrid</option>
                <option value="Remote">Remote</option>
              </select>
              <div className="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-slate-500">
                <span className="material-symbols-outlined">expand_more</span>
              </div>
            </div>
          </div>
          
          <div className="space-y-2">
            <Label htmlFor="status">Status</Label>
             <div className="relative">
              <select
                id="status"
                {...register("status")}
                className="flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-primary/50 border border-slate-300 dark:border-[#344465] bg-white dark:bg-[#1a2232] focus:border-primary dark:focus:border-primary h-14 p-[15px] text-base font-normal leading-normal appearance-none"
              >
                <option value="Draft">Draft</option>
                <option value="Active">Active</option>
                <option value="Closed">Closed</option>
                <option value="Paused">Paused</option>
              </select>
               <div className="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-slate-500">
                <span className="material-symbols-outlined">expand_more</span>
              </div>
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="expiration_date">Application Deadline</Label>
            <Input
              id="expiration_date"
              type="date"
              {...register("expiration_date")}
            />
          </div>
        </div>

        <div className="space-y-2">
          <Label htmlFor="description">Job Description</Label>
          <textarea
            id="description"
            rows={6}
            className="flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-primary/50 border border-slate-300 dark:border-[#344465] bg-white dark:bg-[#1a2232] focus:border-primary dark:focus:border-primary p-[15px] text-base font-normal leading-normal"
            placeholder="Detailed description of the role..."
            {...register("description")}
          />
        </div>
      </div>

      <div className="bg-card-light dark:bg-card-dark p-6 rounded-xl border border-border-light dark:border-border-dark space-y-6">
        <h2 className="text-xl font-bold text-text-primary-light dark:text-text-primary-dark border-b border-border-light dark:border-border-dark pb-4">
          Details & Requirements
        </h2>
        <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark">
          Please add items individually. This structure helps our AI matching system to better compare candidates against your requirements.
        </p>

        {renderListSection(
          "Key Responsibilities", 
          responsibilitiesFields, 
          (val) => appendResponsibility(val), 
          removeResponsibility, 
          "responsibilities",
          "e.g. Lead the frontend development team..."
        )}

        <div className="h-px bg-border-light dark:bg-border-dark my-4"></div>

        {renderListSection(
          "Requirements & Skills", 
          requirementsFields, 
          (val) => appendRequirement(val), 
          removeRequirement, 
          "requirements",
          "e.g. 5+ years of React experience..."
        )}

        <div className="h-px bg-border-light dark:bg-border-dark my-4"></div>

        {renderListSection(
          "Benefits & Perks", 
          benefitsFields, 
          (val) => appendBenefit(val), 
          removeBenefit, 
          "benefits",
          "e.g. Remote work options..."
        )}
      </div>

      <div className="bg-card-light dark:bg-card-dark p-6 rounded-xl border border-border-light dark:border-border-dark space-y-6">
        <h2 className="text-xl font-bold text-text-primary-light dark:text-text-primary-dark border-b border-border-light dark:border-border-dark pb-4">
          Compensation
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="space-y-2">
            <Label htmlFor="salary_currency">Currency</Label>
            <div className="relative">
              <select
                id="salary_currency"
                {...register("salary_currency")}
                className="flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-slate-800 dark:text-white focus:outline-none focus:ring-2 focus:ring-primary/50 border border-slate-300 dark:border-[#344465] bg-white dark:bg-[#1a2232] focus:border-primary dark:focus:border-primary h-14 p-[15px] text-base font-normal leading-normal appearance-none"
              >
                <option value="USD">USD ($)</option>
                <option value="EUR">EUR (€)</option>
                <option value="GBP">GBP (£)</option>
                <option value="TRY">TRY (₺)</option>
              </select>
               <div className="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-slate-500">
                <span className="material-symbols-outlined">expand_more</span>
              </div>
            </div>
          </div>
          
          <div className="space-y-2">
            <Label htmlFor="salary_range_min">Min Salary (Annual)</Label>
            <Input
              id="salary_range_min"
              type="number"
              placeholder="e.g. 80000"
              {...register("salary_range_min")}
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="salary_range_max">Max Salary (Annual)</Label>
            <Input
              id="salary_range_max"
              type="number"
              placeholder="e.g. 120000"
              {...register("salary_range_max")}
            />
          </div>
        </div>
      </div>

      {/* AI Assistant Section */}
      <div className="bg-linear-to-br from-primary/5 to-purple-500/5 dark:from-primary/10 dark:to-purple-500/10 border border-primary/20 rounded-xl p-8 transition-all duration-300 shadow-sm mt-12">
        <div className="flex items-start gap-6">
          <div className="p-3 bg-primary/10 dark:bg-primary/20 rounded-xl text-primary shrink-0 shadow-xs">
             <span className="material-symbols-outlined text-2xl">auto_awesome</span>
          </div>
          <div className="flex-1">
             <div className="flex items-center justify-between mb-3">
                <h3 className="text-xl font-bold text-text-primary-light dark:text-text-primary-dark flex items-center gap-2">
                  AI Assistant
                </h3>
                <button 
                  type="button" 
                  onClick={() => setShowAiSuggestions(!showAiSuggestions)}
                  className="text-sm font-medium text-primary hover:text-primary/80 transition-colors"
                >
                   {showAiSuggestions ? "Hide Suggestions" : "Show Suggestions"}
                </button>
             </div>
             
             {showAiSuggestions && (
                <div className="animate-in fade-in slide-in-from-top-2 duration-300">
                   <p className="text-text-secondary-light dark:text-text-secondary-dark mb-6 max-w-3xl leading-relaxed">
                     Our AI assistant can help you write better job descriptions and optimize your posting for the best candidates. You can generate a draft from scratch or enhance your existing content.
                   </p>
                   <div className="flex flex-wrap gap-4">
                     <Button 
                       type="button" 
                       onClick={handleGenerateDescription} 
                       disabled={generateContentMutation.isPending || assistJobMutation.isPending}
                       className="w-auto gap-2 bg-white dark:bg-card-dark hover:bg-slate-50 dark:hover:bg-slate-800 text-text-primary-light dark:text-text-primary-dark border border-border-light dark:border-border-dark shadow-sm"
                     >
                       {generateContentMutation.isPending ? (
                         <>
                           <div className="animate-spin h-4 w-4 border-2 border-primary border-t-transparent rounded-full"></div>
                           Generating Draft...
                         </>
                       ) : (
                         <>
                           <span className="material-symbols-outlined text-lg">edit_note</span>
                           Generate Description Only
                         </>
                       )}
                     </Button>

                     <Button 
                       type="button" 
                       onClick={handleSmartEnhance} 
                       disabled={generateContentMutation.isPending || assistJobMutation.isPending}
                       className="w-auto gap-2 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white border-0 shadow-md shadow-purple-500/20"
                     >
                       {assistJobMutation.isPending ? (
                         <>
                           <div className="animate-spin h-4 w-4 border-2 border-white border-t-transparent rounded-full"></div>
                           Analyzing...
                         </>
                       ) : (
                         <>
                           <span className="material-symbols-outlined text-lg">auto_awesome</span>
                           Smart Enhance (All Fields)
                         </>
                       )}
                     </Button>
                   </div>
                </div>
             )}
          </div>
        </div>
      </div>

      {/* Review Modal */}
      {reviewData && (
        <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4 animate-in fade-in duration-200">
          <div className="bg-[#1e2532] dark:bg-[#1e2532] border border-[#2b3648] w-full max-w-2xl rounded-2xl shadow-2xl flex flex-col max-h-[90vh] animate-in zoom-in-95 duration-300">
            {/* Modal Header */}
            <div className="flex items-start justify-between p-6 border-b border-[#2b3648] bg-[#1e2532] rounded-t-2xl relative overflow-hidden">
              {/* Subtle gradient glow */}
              <div className="absolute -top-10 -left-10 w-32 h-32 bg-primary/20 rounded-full blur-3xl pointer-events-none"></div>
              
              <div className="flex gap-4 relative z-10">
                <div className="size-12 rounded-xl bg-gradient-to-br from-primary to-purple-600 flex items-center justify-center shadow-lg shadow-primary/20 shrink-0">
                  <span className="material-symbols-outlined text-white text-[28px]">auto_awesome</span>
                </div>
                <div>
                  <h3 className="text-xl font-bold text-white mb-1">AI-Generated Job Details</h3>
                  <p className="text-[#93a5c8] text-sm">
                    Suggestions based on <span className="text-white font-medium">'{watch("title")}'</span>
                  </p>
                </div>
              </div>
              
              <button 
                onClick={closeReview}
                className="text-[#93a5c8] hover:text-white transition-colors rounded-full p-1 hover:bg-white/5 relative z-10"
              >
                <span className="material-symbols-outlined">close</span>
              </button>
            </div>

            {/* Modal Body (Scrollable) */}
            <div className="overflow-y-auto p-6 space-y-8 bg-[#151b26]" style={{
              scrollbarWidth: 'thin',
              scrollbarColor: '#334155 #1e2532'
            }}>
              {/* Section: Basic Info (if different) */}
              {((reviewData.department && reviewData.department !== watch('department')) ||
                (reviewData.location && reviewData.location !== watch('location')) ||
                (reviewData.work_type && reviewData.work_type !== watch('work_type'))) && (
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-[#93a5c8] uppercase tracking-wider">Basic Information</h4>
                  </div>
                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    {reviewData.department && reviewData.department !== watch('department') && (
                      <div className="bg-[#1e2532] border border-[#2b3648] rounded-lg p-3">
                        <div className="text-[10px] text-[#93a5c8] uppercase mb-1">Department</div>
                        <div className="text-sm text-gray-200 font-medium mb-2">{reviewData.department}</div>
                        <button
                          onClick={() => setValue('department', reviewData.department || '')}
                          className="text-xs text-primary hover:underline"
                        >
                          Apply
                        </button>
                      </div>
                    )}
                    {reviewData.location && reviewData.location !== watch('location') && (
                      <div className="bg-[#1e2532] border border-[#2b3648] rounded-lg p-3">
                        <div className="text-[10px] text-[#93a5c8] uppercase mb-1">Location</div>
                        <div className="text-sm text-gray-200 font-medium mb-2">{reviewData.location}</div>
                        <button
                          onClick={() => setValue('location', reviewData.location || '')}
                          className="text-xs text-primary hover:underline"
                        >
                          Apply
                        </button>
                      </div>
                    )}
                    {reviewData.work_type && reviewData.work_type !== watch('work_type') && (
                      <div className="bg-[#1e2532] border border-[#2b3648] rounded-lg p-3">
                        <div className="text-[10px] text-[#93a5c8] uppercase mb-1">Work Type</div>
                        <div className="text-sm text-gray-200 font-medium mb-2">{reviewData.work_type}</div>
                        <button
                          onClick={() => setValue('work_type', reviewData.work_type || '')}
                          className="text-xs text-primary hover:underline"
                        >
                          Apply
                        </button>
                      </div>
                    )}
                  </div>
                </div>
              )}

              {/* Section: Description */}
              {reviewData.description && reviewData.description !== watch('description') && (
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-[#93a5c8] uppercase tracking-wider">Job Description</h4>
                  </div>
                  <div className="bg-[#1e2532] border border-[#2b3648] rounded-lg p-4">
                    <p className="text-sm text-gray-200 leading-relaxed whitespace-pre-wrap">
                      {reviewData.description}
                    </p>
                    <button
                      onClick={() => setValue('description', reviewData.description || '')}
                      className="mt-3 px-4 py-2 bg-primary/10 hover:bg-primary/20 text-primary rounded-lg text-xs font-medium transition-colors border border-primary/20"
                    >
                      Apply Description
                    </button>
                  </div>
                </div>
              )}

              {/* Section: Responsibilities */}
              {reviewData.responsibilities && reviewData.responsibilities.length > 0 && (
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-[#93a5c8] uppercase tracking-wider">Key Responsibilities</h4>
                    <span className="text-[10px] bg-primary/10 text-primary px-2 py-0.5 rounded border border-primary/20">
                      High Confidence
                    </span>
                  </div>
                  <div className="space-y-2">
                    {reviewData.responsibilities.map((item, index) => (
                      <label 
                        key={index}
                        className="group flex items-start gap-3 p-3 rounded-lg bg-[#1e2532] border border-[#2b3648] hover:border-primary/50 cursor-pointer transition-all"
                      >
                        <input
                          type="checkbox"
                          checked={selectedSuggestions.responsibilities[index] || false}
                          onChange={() => handleCheckboxChange('responsibilities', index)}
                          className="mt-1 rounded border-[#2b3648] bg-[#111621] text-primary focus:ring-primary focus:ring-offset-0 size-4 cursor-pointer"
                        />
                        <span className={`text-sm leading-relaxed transition-all ${
                          selectedSuggestions.responsibilities[index] 
                            ? 'text-gray-200 group-hover:text-white' 
                            : 'text-gray-400 line-through'
                        }`}>
                          {item}
                        </span>
                      </label>
                    ))}
                  </div>
                </div>
              )}

              {/* Section: Requirements */}
              {reviewData.requirements && reviewData.requirements.length > 0 && (
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-[#93a5c8] uppercase tracking-wider">Requirements</h4>
                  </div>
                  <div className="space-y-2">
                    {reviewData.requirements.map((item, index) => (
                      <label 
                        key={index}
                        className="group flex items-start gap-3 p-3 rounded-lg bg-[#1e2532] border border-[#2b3648] hover:border-primary/50 cursor-pointer transition-all"
                      >
                        <input
                          type="checkbox"
                          checked={selectedSuggestions.requirements[index] || false}
                          onChange={() => handleCheckboxChange('requirements', index)}
                          className="mt-1 rounded border-[#2b3648] bg-[#111621] text-primary focus:ring-primary focus:ring-offset-0 size-4 cursor-pointer"
                        />
                        <span className={`text-sm leading-relaxed transition-all ${
                          selectedSuggestions.requirements[index] 
                            ? 'text-gray-200 group-hover:text-white' 
                            : 'text-gray-400 line-through'
                        }`}>
                          {item}
                        </span>
                      </label>
                    ))}
                  </div>
                </div>
              )}

              {/* Section: Benefits */}
              {reviewData.benefits && reviewData.benefits.length > 0 && (
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <h4 className="text-xs font-bold text-[#93a5c8] uppercase tracking-wider">Suggested Benefits</h4>
                  </div>
                  <div className="p-4 rounded-lg bg-[#1e2532] border border-[#2b3648] border-dashed flex flex-wrap gap-2">
                    {reviewData.benefits.map((item, index) => (
                      <label 
                        key={index}
                        className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full border text-xs font-medium cursor-pointer transition-all"
                        style={{
                          backgroundColor: selectedSuggestions.benefits[index] ? 'rgb(48 110 232 / 0.1)' : 'transparent',
                          borderColor: selectedSuggestions.benefits[index] ? 'rgb(48 110 232 / 0.2)' : '#2b3648',
                          color: selectedSuggestions.benefits[index] ? '#306ee8' : '#93a5c8'
                        }}
                      >
                        <input
                          type="checkbox"
                          checked={selectedSuggestions.benefits[index] || false}
                          onChange={() => handleCheckboxChange('benefits', index)}
                          className="sr-only"
                        />
                        <span className="material-symbols-outlined text-[14px]">
                          {selectedSuggestions.benefits[index] ? 'check' : 'add'}
                        </span>
                        {item}
                      </label>
                    ))}
                  </div>
                </div>
              )}
            </div>

            {/* Modal Footer */}
            <div className="p-6 border-t border-[#2b3648] bg-[#1e2532] rounded-b-2xl flex flex-col sm:flex-row items-center justify-between gap-4">
              <button 
                onClick={closeReview}
                className="text-sm font-medium text-[#93a5c8] hover:text-red-400 transition-colors px-2 py-1"
              >
                Discard Suggestions
              </button>
              
              <div className="flex items-center gap-3 w-full sm:w-auto">
                <button 
                  onClick={acceptSelectedSuggestions}
                  className="flex-1 sm:flex-none px-5 py-2.5 rounded-lg border border-[#2b3648] text-white font-medium text-sm hover:bg-[#2b3648] transition-colors focus:ring-2 focus:ring-primary/50"
                >
                  Add Selected
                </button>
                
                <button 
                  onClick={acceptAllSuggestions}
                  className="flex-1 sm:flex-none px-5 py-2.5 rounded-lg bg-primary hover:bg-primary/90 text-white font-medium text-sm shadow-lg shadow-primary/25 transition-all flex items-center justify-center gap-2 focus:ring-2 focus:ring-offset-2 focus:ring-offset-[#1e2532] focus:ring-primary"
                >
                  <span>Replace All</span>
                  <span className="material-symbols-outlined text-[18px]">check</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      <div className="flex justify-end gap-4">
        <Button 
          type="button" 
          className="w-32 bg-transparent border border-border-light dark:border-border-dark text-text-primary-light dark:text-text-primary-dark hover:bg-slate-100 dark:hover:bg-slate-800"
          onClick={() => router.back()}
        >
          Cancel
        </Button>
        <Button 
          type="submit" 
          className="w-48"
          disabled={isPending}
        >
          {isPending ? (isEditing ? "Updating..." : "Creating...") : (isEditing ? "Update Job Posting" : "Create Job Posting")}
        </Button>
      </div>
    </form>
  );
}
