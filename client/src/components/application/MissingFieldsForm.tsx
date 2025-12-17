"use client";

import { useState } from "react";
import type { CoverageDetails, AdditionalFields } from "@/features/applications/types";

interface MissingFieldsFormProps {
  coverageDetails: CoverageDetails;
  onSubmit: (fields: AdditionalFields) => void;
  onBack: () => void;
  isSubmitting: boolean;
}

export function MissingFieldsForm({
  coverageDetails,
  onSubmit,
  onBack,
  isSubmitting,
}: MissingFieldsFormProps) {
  const [fields, setFields] = useState<AdditionalFields>({});
  const [languagesInput, setLanguagesInput] = useState("");
  const [hobbiesInput, setHobbiesInput] = useState("");

  // Determine which fields to show based on missing fields
  const showLocationFields = coverageDetails.personal_information?.missing_fields?.some(
    (f) => f.includes("city") || f.includes("country")
  );
  const showLanguages = coverageDetails.skills?.missing_fields?.includes("languages");
  const additionalMissing = coverageDetails.additional_information?.missing_fields || [];

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    const submittedFields: AdditionalFields = { ...fields };
    
    // Parse languages
    if (languagesInput.trim()) {
      submittedFields.languages = languagesInput
        .split(",")
        .map((l) => l.trim())
        .filter(Boolean);
    }
    
    // Parse hobbies
    if (hobbiesInput.trim()) {
      submittedFields.hobbies = hobbiesInput
        .split(",")
        .map((h) => h.trim())
        .filter(Boolean);
    }
    
    onSubmit(submittedFields);
  };

  const inputClasses =
    "w-full rounded-lg border border-border-dark bg-background-dark px-4 py-3 text-sm text-white placeholder-gray-500 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary transition-colors";
  const labelClasses = "block text-sm font-medium text-gray-300 mb-2";

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="text-center space-y-2">
        <div className="mx-auto flex size-16 items-center justify-center rounded-full bg-primary/10">
          <span className="material-symbols-outlined text-3xl text-primary">
            edit_note
          </span>
        </div>
        <h3 className="text-xl font-bold text-white">Complete Your Profile</h3>
        <p className="text-sm text-gray-400">
          Fill in the missing information to strengthen your application
        </p>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-5">
        {/* Location Fields */}
        {showLocationFields && (
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className={labelClasses}>City</label>
              <input
                type="text"
                placeholder="e.g., Istanbul"
                value={fields.city || ""}
                onChange={(e) => setFields({ ...fields, city: e.target.value })}
                className={inputClasses}
              />
            </div>
            <div>
              <label className={labelClasses}>Country</label>
              <input
                type="text"
                placeholder="e.g., Turkey"
                value={fields.country || ""}
                onChange={(e) => setFields({ ...fields, country: e.target.value })}
                className={inputClasses}
              />
            </div>
          </div>
        )}

        {/* Languages */}
        {showLanguages && (
          <div>
            <label className={labelClasses}>Languages</label>
            <input
              type="text"
              placeholder="e.g., English, Turkish, German"
              value={languagesInput}
              onChange={(e) => setLanguagesInput(e.target.value)}
              className={inputClasses}
            />
            <p className="mt-1 text-xs text-gray-500">
              Separate multiple languages with commas
            </p>
          </div>
        )}

        {/* Additional Information Fields */}
        {additionalMissing.includes("driving_license") && (
          <div>
            <label className={labelClasses}>Driving License</label>
            <select
              value={fields.driving_license || ""}
              onChange={(e) =>
                setFields({ ...fields, driving_license: e.target.value })
              }
              className={inputClasses}
            >
              <option value="">Select...</option>
              <option value="None">None</option>
              <option value="Class B">Class B (Car)</option>
              <option value="Class A">Class A (Motorcycle)</option>
              <option value="Class C">Class C (Truck)</option>
              <option value="Class D">Class D (Bus)</option>
            </select>
          </div>
        )}

        {additionalMissing.includes("military_status") && (
          <div>
            <label className={labelClasses}>Military Status</label>
            <select
              value={fields.military_status || ""}
              onChange={(e) =>
                setFields({ ...fields, military_status: e.target.value })
              }
              className={inputClasses}
            >
              <option value="">Select...</option>
              <option value="Completed">Completed</option>
              <option value="Exempt">Exempt</option>
              <option value="Postponed">Postponed</option>
              <option value="Not Applicable">Not Applicable</option>
            </select>
          </div>
        )}

        {additionalMissing.includes("availability") && (
          <div>
            <label className={labelClasses}>Availability</label>
            <select
              value={fields.availability || ""}
              onChange={(e) =>
                setFields({ ...fields, availability: e.target.value })
              }
              className={inputClasses}
            >
              <option value="">Select...</option>
              <option value="Immediately">Immediately</option>
              <option value="2 weeks">2 weeks notice</option>
              <option value="1 month">1 month notice</option>
              <option value="2 months">2 months notice</option>
              <option value="3+ months">3+ months notice</option>
            </select>
          </div>
        )}

        {/* Relocation & Travel */}
        {(additionalMissing.includes("willing_to_relocate") ||
          additionalMissing.includes("willing_to_travel")) && (
          <div className="grid grid-cols-2 gap-4">
            {additionalMissing.includes("willing_to_relocate") && (
              <div>
                <label className={labelClasses}>Willing to Relocate?</label>
                <div className="flex gap-3">
                  <label className="flex items-center gap-2 cursor-pointer">
                    <input
                      type="radio"
                      name="relocate"
                      checked={fields.willing_to_relocate === true}
                      onChange={() =>
                        setFields({ ...fields, willing_to_relocate: true })
                      }
                      className="accent-primary"
                    />
                    <span className="text-sm text-gray-300">Yes</span>
                  </label>
                  <label className="flex items-center gap-2 cursor-pointer">
                    <input
                      type="radio"
                      name="relocate"
                      checked={fields.willing_to_relocate === false}
                      onChange={() =>
                        setFields({ ...fields, willing_to_relocate: false })
                      }
                      className="accent-primary"
                    />
                    <span className="text-sm text-gray-300">No</span>
                  </label>
                </div>
              </div>
            )}
            {additionalMissing.includes("willing_to_travel") && (
              <div>
                <label className={labelClasses}>Willing to Travel?</label>
                <div className="flex gap-3">
                  <label className="flex items-center gap-2 cursor-pointer">
                    <input
                      type="radio"
                      name="travel"
                      checked={fields.willing_to_travel === true}
                      onChange={() =>
                        setFields({ ...fields, willing_to_travel: true })
                      }
                      className="accent-primary"
                    />
                    <span className="text-sm text-gray-300">Yes</span>
                  </label>
                  <label className="flex items-center gap-2 cursor-pointer">
                    <input
                      type="radio"
                      name="travel"
                      checked={fields.willing_to_travel === false}
                      onChange={() =>
                        setFields({ ...fields, willing_to_travel: false })
                      }
                      className="accent-primary"
                    />
                    <span className="text-sm text-gray-300">No</span>
                  </label>
                </div>
              </div>
            )}
          </div>
        )}

        {/* Hobbies */}
        {additionalMissing.includes("hobbies") && (
          <div>
            <label className={labelClasses}>Hobbies & Interests</label>
            <input
              type="text"
              placeholder="e.g., Reading, Photography, Hiking"
              value={hobbiesInput}
              onChange={(e) => setHobbiesInput(e.target.value)}
              className={inputClasses}
            />
            <p className="mt-1 text-xs text-gray-500">
              Separate multiple hobbies with commas
            </p>
          </div>
        )}

        {/* Action Buttons */}
        <div className="flex gap-3 pt-2">
          <button
            type="button"
            onClick={onBack}
            disabled={isSubmitting}
            className="flex-1 rounded-lg bg-[#243047] py-3 text-sm font-bold text-gray-300 transition-colors hover:bg-[#2f3e5b] disabled:opacity-50"
          >
            Back
          </button>
          <button
            type="submit"
            disabled={isSubmitting}
            className="flex-1 rounded-lg bg-primary py-3 text-sm font-bold text-white shadow-lg shadow-primary/25 transition-all hover:bg-primary/90 disabled:opacity-50"
          >
            {isSubmitting ? (
              <span className="flex items-center justify-center gap-2">
                <span className="material-symbols-outlined animate-spin text-lg">
                  progress_activity
                </span>
                Submitting...
              </span>
            ) : (
              "Submit Application"
            )}
          </button>
        </div>
      </form>
    </div>
  );
}

